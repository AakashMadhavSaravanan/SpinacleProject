from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pymongo import MongoClient
from pydantic import BaseModel
import random

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
users_collection = db["users"]
profiles_collection = db["profiles"]

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
    currentStage: str  # Changed from current_stage to currentStage
    loanNeed: str  # Changed from loan_need to loanNeed

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
