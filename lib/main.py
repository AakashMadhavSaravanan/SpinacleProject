from datetime import datetime, timezone
import json
import os
import shutil
from fastapi import FastAPI, File, Form, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from pymongo import MongoClient
from pydantic import BaseModel
import random
import gridfs
from bson import ObjectId
from fastapi.responses import JSONResponse  
from fastapi.encoders import jsonable_encoder  
import io
import uuid
import cv2
import tempfile
import easyocr
import google.generativeai as genai
from PIL import Image
from typing import Optional
from collections import defaultdict


app = FastAPI()

# ✅ ADD ROOT ENDPOINT TO PREVENT 404 ERROR
@app.get("/")
async def root():
    return {"message": "Server is running"}

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust for security
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["test_database"]
fs = gridfs.GridFS(db)  # Initialize GridFS
users_collection = db["users"]
profiles_collection = db["profiles"]
files_collection= db["files"]
health_scores_collection = db["health_scores"]
health_scores_collection.create_index("phone", unique=True)

# Pydantic models for request body
class RegisterRequest(BaseModel):
    phone: str

class VerifyRequest(BaseModel):
    phone: str
    otp: str

class ProfileRequest(BaseModel):
    phone: str
    whoYouAre: str
    name: str
    email: str
    age: str
    location: str
    diagnosis: str
    currentStage: str
    loanNeed: str
    password: str

class ProfileUpdateRequest(BaseModel):
    whoYouAre: str
    name: str
    age: str
    location: str
    diagnosis: str
    currentStage: str
    loanNeed: str

class ProfilePhoneEmailRequest(BaseModel):
    email: str
    phone: str

class PasswordUpdateRequest(BaseModel):
    new_password: str

# Request Model for Login
class LoginRequest(BaseModel):
    email_or_phone: str
    password: str

class DailyCheckupData(BaseModel):
    phone: str
    name: str
    blood_pressure: str
    heart_rate: str
    temperature: str
    notes: str    

class ChemotherapyData(BaseModel):
    phone: str
    name: str
    date: str  # Add date field
    type: str
    dosage_per_session: str
    number_of_sessions: str
    total_dosage: str
    side_effects: str

class DiagnosisData(BaseModel):
    phone: str
    name: str
    diagnosis_name: str
    date: str  # Format: "YYYY-MM-DD"
    severity: str
    symptoms: str
    treatment_plan: str

class SleepTimeData(BaseModel):
    phone: str
    name: str
    hours: str
    minutes: str
    date: str = None  # As string in 'yyyy-MM-dd' format

class PhysicalActivityData(BaseModel):
    phone: str
    name: str
    activity: str
    weight: str
    duration: str
    caloriesBurned: str
    date: str  # Expected in "YYYY-MM-DD" format    

class DietNutritionModel(BaseModel):
    phone: str
    date: str
    breakfast: str
    morning_snack: str
    lunch: str
    evening_snack: str
    dinner: str    

#Load Gemini API Key
#GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
genai.configure(api_key="AIzaSyBRMApBI9PGciPtRyblC73FHHMb6whGkLY")                        
# EasyOCR reader
reader = easyocr.Reader(['en'])

# In-memory session storage
user_sessions = defaultdict(list)

# ======================= Request Models =========================
class QuestionRequest(BaseModel):
    prompt: str
    session_id: str

# ======================= AI Logic ===============================
def process_image_with_ocr(image_path):
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    processed = cv2.adaptiveThreshold(image, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
                                      cv2.THRESH_BINARY, 11, 2)
    cv2.imwrite(image_path, processed)
    result = reader.readtext(image_path, detail=0)
    return " ".join(result)

def classify_image_with_gemini(image_path: str) -> str:
    model = genai.GenerativeModel("models/gemini-1.5-flash")
    with open(image_path, "rb") as f:
        image = Image.open(io.BytesIO(f.read()))
    prompt = (
        "You are a helpful assistant. Classify the uploaded image as one of the following:\n"
        "- 'report' (if it is a medical report)\n"
        "- 'ingredients' (if it contains food ingredients)\n"
    )
    response = model.generate_content([prompt, image])
    return response.text.strip().lower()

def summarize_report_text(ocr_text: str) -> str:
    prompt = f"""
You are Xecure AI, a kind medical assistant for cancer patients.

The following text is extracted from a medical report. It may be imperfect. Please summarize in simple, caring language.
Focus on extracting: patient name, date, doctor name, treatment advice, etc.

Limit your response to a short paragraph. Reassure the patient gently.
Avoid complex medical jargon.

OCR Text:
{ocr_text}
"""
    model = genai.GenerativeModel("models/gemini-1.5-flash")
    response = model.generate_content(prompt)
    return response.text.strip()

def generate_recipe(image_path: str) -> str:
    return "recipe generated by tharun."

def answer_user_question(question: str, memory: list) -> str:
    past_context = "\n".join([f"User: {q}\nAI: {a}" for q, a in memory[-3:]])
    prompt = f"""
You are Xecure AI, a kind and supportive medical assistant for cancer patients.

Respond shortly, in a friendly and simple way. Use easy words that a patient can understand.
Keep the answer under 50 words unless it's really needed.

Conversation so far:
{past_context}

New Question:
{question}

Kind Answer:
"""
    model = genai.GenerativeModel("models/gemini-1.5-flash")
    response = model.generate_content(prompt)
    return response.text.strip()



@app.post("/gemini")
async def ask_gemini(request: QuestionRequest):
    try:
        print("✅ Received request at /gemini")
        print("Prompt:", request.prompt)
        session_id = request.session_id or str(uuid.uuid4())
        memory = user_sessions.get(session_id, [])

        answer = answer_user_question(request.prompt, memory)

        memory.append((request.prompt, answer))
        if len(memory) > 3:
            memory.pop(0)
        user_sessions[session_id] = memory
        
        print("✅ Gemini response:", answer)
        return {"response": answer}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/upload-image/")
async def upload_image(file: UploadFile = File(...), session_id: Optional[str] = Form(None)):
    temp_path = None
    try:
        file_ext = os.path.splitext(file.filename)[1]
        with tempfile.NamedTemporaryFile(delete=False, suffix=file_ext) as temp_file:
            content = await file.read()
            temp_file.write(content)
            temp_path = temp_file.name

        image_type = classify_image_with_gemini(temp_path)

        if image_type == 'report':
            ocr_text = process_image_with_ocr(temp_path)
            summary = summarize_report_text(ocr_text)
            return {"type": "report", "result": summary}

        elif image_type == 'ingredients':
            recipe = generate_recipe(temp_path)
            return {"type": "ingredients", "result": recipe}

        else:
            return {"type": "unknown", "result": "Unsupported image type"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        if temp_path and os.path.exists(temp_path):
            os.unlink(temp_path)


# Register user and generate OTP
@app.post("/register/")
async def register_user(request: RegisterRequest):
    phone = request.phone
    otp = str(random.randint(100000, 999999))  # Generate new OTP
    
    user = users_collection.find_one({"phone": phone})
    
    if user:
        # Update existing user's OTP
        users_collection.update_one({"phone": phone}, {"$set": {"otp": otp, "verified": False}})
    else:
        # Create new entry
        users_collection.insert_one({"phone": phone, "otp": otp, "verified": False})

    return {"status": "success", "message": "OTP generated", "otp": otp}  # Return OTP for testing

# Verify OTP
@app.post("/verify/")
async def verify_otp(request: VerifyRequest):
    user = users_collection.find_one({"phone": request.phone})
    if not user or user["otp"] != request.otp:
        raise HTTPException(status_code=400, detail="Invalid OTP")
    
    users_collection.update_one({"phone": request.phone}, {"$set": {"verified": True}})
    return {"status": "success", "message": "Phone number verified"}

# Resend OTP
@app.post("/resend/")
async def resend_otp(request: RegisterRequest):
    phone = request.phone
    user = users_collection.find_one({"phone": phone})
    
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Generate a new OTP
    new_otp = str(random.randint(100000, 999999))

    # Update the existing user record with the new OTP
    users_collection.update_one({"phone": phone}, {"$set": {"otp": new_otp, "verified": False}})

    return {"status": "success", "message": "New OTP generated", "otp": new_otp}  # Return OTP for testing

# Create profile
@app.post("/create-profile/")
async def create_profile(request: ProfileRequest):
    profile_data = request.dict()
    
    # Check if the phone number exists in the users collection (must be registered first)
    user = users_collection.find_one({"phone": request.phone})
    if not user:
        raise HTTPException(status_code=400, detail="Phone number not found. Register first.")

    # Insert profile data into the profiles collection
    profiles_collection.insert_one(profile_data)
    
    return {"status": "success", "message": "Profile created successfully"}

@app.get("/get_full_profile/{phone}")
async def get_full_profile(phone: str):
    profile = db.profiles.find_one({"phone": phone}, {"_id": 0, "phone": 0, "email": 0})  # Exclude phone & email
    if profile:
        return profile
    return {"error": "Profile not found"}

@app.put("/update_profile/{phone}")
async def update_profile(phone: str, updated_data: ProfileUpdateRequest):
    phone = str(phone)  # Ensure it's a string

    found_profile = profiles_collection.find_one({"phone": phone})
    if not found_profile:
        raise HTTPException(status_code=404, detail="Profile not found in DB")

    result = profiles_collection.update_one(
        {"phone": phone},
        {"$set": updated_data.dict()}
    )

    if result.modified_count == 0:
        return {"message": "No changes detected"}

    return {"message": "Profile updated successfully"}

@app.get("/get_profile/{phone}")
async def get_profile(phone: str):
    profile = profiles_collection.find_one({"phone": phone})
    if not profile:
        raise HTTPException(status_code=404, detail="Profile not found")
    return {"_id": str(profile["_id"]), "email": profile["email"], "phone": profile["phone"]}

# Update email and phone number using _id
@app.put("/update_contact/{user_id}")
async def update_contact(user_id: str, request: ProfilePhoneEmailRequest):
    from bson import ObjectId

    if not ObjectId.is_valid(user_id):
        raise HTTPException(status_code=400, detail="Invalid user ID format")

    print(f"Updating profile for user_id: {user_id}")

    result = profiles_collection.update_one(
        {"_id": ObjectId(user_id)},  
        {"$set": {"email": request.email, "phone": request.phone}}
    )

    if result.modified_count == 0:
        raise HTTPException(status_code=404, detail="Profile not found or no changes detected")

    return {"message": "Profile updated successfully"}

# ✅ File Upload Endpoint
@app.post("/upload/")
async def upload_file(file: UploadFile = File(...), document_type: str = Form(...), phone_number: str = Form(...)):
    try:
        file_data = await file.read()  # Read file content
        file_id = fs.put(file_data, filename=file.filename, content_type=file.content_type, document_type=document_type)

        # ✅ Store file metadata in the 'profiles' collection (linked to the user)
        files_collection.update_one(
            {"phone": phone_number},
            {"$push": {"uploaded_files": {"file_id": str(file_id), "filename": file.filename, "document_type": document_type}}},
            upsert=True
        )

        return {"status": "success", "message": "File uploaded successfully", "file_id": str(file_id)}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"File upload failed: {str(e)}")

@app.get("/get_password/{phone}")
async def get_password(phone: str):
    user = profiles_collection.find_one({"phone": phone})
    if not user or "password" not in user:
        raise HTTPException(status_code=404, detail="User not found")
    return {"password": user["password"]}  # If hashed, return accordingly

@app.put("/update_password/{phone}")
async def update_password(phone: str, request: PasswordUpdateRequest):
    result = profiles_collection.update_one({"phone": phone}, {"$set": {"password": request.new_password}})
    
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="User not found")
    
    return {"message": "Password updated successfully"}

# Login API
@app.post("/login")
def login_user(request: LoginRequest):
    print("Login request received:", request.email_or_phone)

    user = profiles_collection.find_one(
        {"$or": [{"email": request.email_or_phone}, {"phone": request.email_or_phone}]}
    )

    print("User found in DB:", user)  # Debugging line

    if not user:
        print("User not found!")
        raise HTTPException(status_code=401, detail="Invalid credentials")

    if user["password"] != request.password:
        print("Incorrect password!")
        raise HTTPException(status_code=401, detail="Invalid credentials")

    print("Login successful!")
    
    return {
        "success": True,
        "user": {
            "id": str(user["_id"]),
            "whoYouAre": user.get("whoYouAre"),
            "name": user.get("name"),
            "email": user.get("email"),
            "phone": user.get("phone"),
            "age": user.get("age"),
            "location": user.get("location"),
            "diagnosis": "Ovarian Cancer",
            "currentStage": "Stage 2",
            "loanNeed": "",
        }
    }

@app.post("/forgot_password/")
async def forgot_password(request: RegisterRequest):
    phone_or_email = request.phone  # Can be phone or email
    user = None

    # Check if input is email or phone
    if "@" in phone_or_email:
        # Search by email in profiles collection
        profile = profiles_collection.find_one({"email": phone_or_email})
        if profile:
            user = users_collection.find_one({"phone": profile["phone"]})
    else:
        # Search by phone in users collection
        user = users_collection.find_one({"phone": phone_or_email})

    if not user:
        raise HTTPException(
            status_code=404,
            detail="Phone number/email is not registered"
        )

    # Generate and store a new OTP
    otp = str(random.randint(100000, 999999))
    users_collection.update_one(
        {"phone": user["phone"]},
        {"$set": {"otp": otp, "verified": False}}
    )

    return {
        "status": "success",
        "message": "OTP sent",
        "otp": otp,  # For testing, remove in production
        "phone": user["phone"]  # Return phone for SharedPrefs storage
    }


# In main.py
@app.post("/verify_forgot_password_otp/")
async def verify_forgot_password_otp(request: VerifyRequest):
    user = users_collection.find_one({"phone": request.phone})
    
    if not user:
        raise HTTPException(status_code=404, detail="Account not found")
    
    if user["otp"] != request.otp:
        raise HTTPException(status_code=400, detail="Invalid OTP")
    
    # Only mark OTP as verified (no password change)
    users_collection.update_one(
        {"phone": request.phone},
        {"$set": {"verified": True}}  # Just verification flag
    )
    
    return {
        "status": "success",
        "message": "Identity verified - you may now login",
        "phone": request.phone
    }

@app.post("/api/save_daily_checkup/")
async def save_daily_checkup(data: DailyCheckupData):
    try:
        if not data.phone:
            raise HTTPException(status_code=400, detail="Phone number is required")
            
        # Get current datetime in UTC
        current_date = datetime.now(timezone.utc).date()
        current_datetime = datetime.now(timezone.utc)
        
        checkup_data = {
            "phone": data.phone,
            "name": data.name,
            "daily_checkups": {
                str(current_date): {
                    "blood_pressure": data.blood_pressure,
                    "heart_rate": data.heart_rate,
                    "temperature": data.temperature,
                    "notes": data.notes,
                    "timestamp": current_datetime
                }
            }
        }
        
        # Validate data
        if not all([data.blood_pressure, data.heart_rate, data.temperature]):
            raise HTTPException(status_code=400, detail="All vital signs are required")

        existing_record = health_scores_collection.find_one({"phone": data.phone})
        
        if existing_record:
            update_result = health_scores_collection.update_one(
                {"phone": data.phone},
                {"$set": {
                    f"daily_checkups.{str(current_date)}": checkup_data["daily_checkups"][str(current_date)]
                }}
            )
            if update_result.modified_count == 0:
                raise HTTPException(status_code=500, detail="Failed to update record")
        else:
            insert_result = health_scores_collection.insert_one(checkup_data)
            if not insert_result.inserted_id:
                raise HTTPException(status_code=500, detail="Failed to create record")
            
        return JSONResponse(
            content=jsonable_encoder({
                "status": "success", 
                "message": "Daily checkup saved successfully",
                "date": str(current_date)
            }),
            status_code=200
        )
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Server error: {str(e)}")
    
@app.post("/api/save_chemotherapy/")
async def save_chemotherapy(data: ChemotherapyData):
    try:
        if not data.phone:
            raise HTTPException(status_code=400, detail="Phone number is required")
            
        current_datetime = datetime.now(timezone.utc)
        chemotherapy_data = {
            "type": data.type,
            "dosage_per_session": data.dosage_per_session,
            "number_of_sessions": data.number_of_sessions,
            "total_dosage": data.total_dosage,
            "side_effects": data.side_effects,
            "timestamp": current_datetime
        }
        
        existing_record = health_scores_collection.find_one({"phone": data.phone})
        
        if existing_record:
            # Store under the provided date
            update_result = health_scores_collection.update_one(
                {"phone": data.phone},
                {"$set": {f"chemotherapy_sessions.{data.date}": chemotherapy_data}}
            )
            if update_result.modified_count == 0:
                raise HTTPException(status_code=500, detail="Failed to update record")
        else:
            new_record = {
                "phone": data.phone,
                "name": data.name,
                "chemotherapy_sessions": {
                    data.date: chemotherapy_data
                },
                "created_at": current_datetime
            }
            insert_result = health_scores_collection.insert_one(new_record)
            if not insert_result.inserted_id:
                raise HTTPException(status_code=500, detail="Failed to create record")
            
        return JSONResponse(
            content=jsonable_encoder({
                "status": "success", 
                "message": "Chemotherapy details saved successfully",
                "date": data.date
            }),
            status_code=200
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.post("/api/save_diagnosis/")
async def save_diagnosis(data: DiagnosisData):
    try:
        if not data.phone:
            raise HTTPException(status_code=400, detail="Phone number is required")
            
        current_datetime = datetime.now(timezone.utc)
        diagnosis_data = {
            "diagnosis_name": data.diagnosis_name,
            "date": data.date,
            "severity": data.severity,
            "symptoms": data.symptoms,
            "treatment_plan": data.treatment_plan,
            "timestamp": current_datetime
        }
        
        # Validate required fields
        if not all([data.diagnosis_name, data.date, data.severity]):
            raise HTTPException(status_code=400, detail="Diagnosis name, date and severity are required")

        existing_record = health_scores_collection.find_one({"phone": data.phone})
        
        if existing_record:
            # Update existing document
            update_result = health_scores_collection.update_one(
                {"phone": data.phone},
                {"$set": {f"diagnosis.{data.date}": diagnosis_data}}
            )
            if update_result.modified_count == 0:
                raise HTTPException(status_code=500, detail="Failed to update diagnosis record")
        else:
            # Create new document
            new_record = {
                "phone": data.phone,
                "name": data.name,
                "diagnosis": {
                    data.date: diagnosis_data
                },
                "created_at": current_datetime
            }
            insert_result = health_scores_collection.insert_one(new_record)
            if not insert_result.inserted_id:
                raise HTTPException(status_code=500, detail="Failed to create record")
            
        return JSONResponse(
            content=jsonable_encoder({
                "status": "success", 
                "message": "Diagnosis details saved successfully",
                "date": data.date
            }),
            status_code=200
        )
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Server error: {str(e)}")    
    
@app.post("/api/save_sleep_time/")
async def save_sleep_time(data: SleepTimeData):
    try:
        print("Received Data:", data.dict())

        if not data.phone:
            raise HTTPException(status_code=400, detail="Phone number is required")

        # Validate date format
        try:
            entry_date = datetime.strptime(data.date, "%Y-%m-%d").date()
        except ValueError:
            raise HTTPException(status_code=400, detail="Invalid date format. Use YYYY-MM-DD")

        current_datetime = datetime.now(timezone.utc)
        sleep_data = {
            "hours": data.hours,
            "minutes": data.minutes,
            "date": data.date,
            "timestamp": current_datetime
        }

        if not all([data.hours, data.minutes, data.date]):
            raise HTTPException(status_code=400, detail="All fields are required")

        existing_record = health_scores_collection.find_one({"phone": data.phone})

        if existing_record:
            result = health_scores_collection.update_one(
                {"phone": data.phone},
                {"$set": {f"sleep_time.{data.date}": sleep_data}}
            )
            if result.modified_count == 0:
                raise HTTPException(status_code=500, detail="Failed to update sleep time record")
        else:
            new_record = {
                "phone": data.phone,
                "name": data.name,
                "sleep_time": {
                    data.date: sleep_data
                },
                "created_at": current_datetime,
                "updated_at": current_datetime
            }
            result = health_scores_collection.insert_one(new_record)
            if not result.inserted_id:
                raise HTTPException(status_code=500, detail="Failed to create record")

        return JSONResponse(
            content={
                "status": "success",
                "message": "Sleep time saved successfully",
                "date": data.date
            },
            status_code=200
        )

    except HTTPException as e:
        print("HTTP Exception:", e.detail)
        raise
    except Exception as e:
        print("Server Error:", str(e))
        raise HTTPException(status_code=500, detail=f"Server error: {str(e)}")

@app.post("/save_physical_activity")
async def save_physical_activity(data: PhysicalActivityData):
    try:
        # Check if the user's entry for the date exists
        user_entry = health_scores_collection.find_one({"phone": data.phone})

        if user_entry:
            # Update existing entry
            health_scores_collection.update_one(
                {"phone": data.phone},
                {
                    "$set": {
                        f"Physical Activity.{data.date}": {
                            "activity": data.activity,
                            "weight": data.weight,
                            "duration": data.duration,
                            "caloriesBurned": data.caloriesBurned,
                        }
                    }
                },
            )
        else:
            # Create new entry
            health_scores_collection.insert_one({
                "phone": data.phone,
                "Physical Activity": {
                    data.date: {
                        "activity": data.activity,
                        "weight": data.weight,
                        "duration": data.duration,
                        "caloriesBurned": data.caloriesBurned,
                    }
                }
            })

        return {"status": "success", "message": "Physical activity saved successfully"}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    
@app.post("/save_diet_nutrition")
async def save_diet_nutrition(data: DietNutritionModel):
    try:
        user_entry = health_scores_collection.find_one({"phone": data.phone})

        if user_entry:
            health_scores_collection.update_one(
                {"phone": data.phone},
                {"$set": {f"Diet and Nutrition.{data.date}": {
                    "breakfast": data.breakfast,
                    "morningSnack": data.morning_snack,
                    "lunch": data.lunch,
                    "eveningSnack": data.evening_snack,
                    "dinner": data.dinner
                }}}
            )
        else:
            health_scores_collection.insert_one({
                "phone": data.phone,
                "Diet and Nutrition": {
                    data.date: {
                        "breakfast": data.breakfast,
                        "morningSnack": data.morning_snack,
                        "lunch": data.lunch,
                        "eveningSnack": data.evening_snack,
                        "dinner": data.dinner
                    }
                }
            })

        return {"status": "success", "message": "Diet and nutrition saved successfully"}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
