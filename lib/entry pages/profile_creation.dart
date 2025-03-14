import 'dart:convert';
import '../services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile_request.dart';
import '../Main Pages/home.dart';
import '../services/api_services.dart'; // Import the API service

// Common gradient background widget
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade700,
            Colors.black,
          ],
        ),
      ),
      child: child,
    );
  }
}

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  _ProfileCreationScreenState createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _loanNeedController = TextEditingController();

  String? _whoYouAre;
  String? _diagnosis;
  String? _currentStage;

  final List<String> _whoYouAreOptions = [
    'Care giver',
    'Patient',
  ];

  final List<String> diagnosisOptions = [
    'Breast Cancer', 'Lung Cancer', 'Colon Cancer', 'Prostate Cancer', 'Liver Cancer', 'Stomach Cancer', 'Bladder Cancer','Brain Cancer', 'Blood Cancer', 'Ovarian Cancer', 'Others',
  ];

  final List<String> currentStageOptions = [
    'Stage 1', 'Stage 2',
  ];

  Future<void> _createProfile() async {
  String? phoneNumber = await SharedPrefs.getStoredPhoneNumber();
  
  if (phoneNumber == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Phone number not found. Please register again.")),
    );
    return;
  }

  final profile = ProfileRequest(
    phone: phoneNumber,  // Now phone is included
    whoYouAre: _whoYouAre!,
    name: _nameController.text,
    email: _emailController.text,
    age: _ageController.text,
    location: _locationController.text,
    diagnosis: _diagnosis!,
    currentStage: _currentStage!,
    loanNeed: _loanNeedController.text,
  );

    try {
    // ✅ Debugging: Check if ProfileRequest is correctly created
    print(profile.runtimeType); // Should print 'ProfileRequest'
    print(jsonEncode(profile.toJson())); // Check the actual JSON sent

    // ✅ Call the API to create the profile
    final response = await ApiService.createProfile(profile);

    // ✅ Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'])),
    );

    // ✅ Navigate to home page on success
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: XecureLogo()),
                  SizedBox(height: 10),
                  Text('Registration', style: headerStyle),
                  Text('Enter your details to continue', style: subTextStyle),
                  SizedBox(height: 20),
                  _buildDropdown(
                    hintText: 'Who you are',
                    icon: Icons.person_outline,
                    items: _whoYouAreOptions,
                    onChanged: (value) {
                      setState(() {
                        _whoYouAre = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildTextField('Enter your name', Icons.person, _nameController),
                  SizedBox(height: 20),
                  _buildTextField('Enter your email', Icons.email, _emailController),
                  SizedBox(height: 20),
                  _buildTextField('Enter your age', Icons.calendar_today, _ageController),
                  SizedBox(height: 20),
                  _buildTextField('Enter your location', Icons.location_on, _locationController),
                  SizedBox(height: 20),
                  _buildDropdown(
                    hintText: 'Diagnosis',
                    icon: Icons.medical_services,
                    items: diagnosisOptions,
                    onChanged: (value) {
                      setState(() {
                        _diagnosis = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildDropdown(
                    hintText: 'Current stage',
                    icon: Icons.timeline,
                    items: currentStageOptions,
                    onChanged: (value) {
                      setState(() {
                        _currentStage = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildTextField('Loan need', Icons.monetization_on, _loanNeedController),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _createProfile,
                      style: buttonStyle,
                      child: Text('Register', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// Logo widget
class XecureLogo extends StatelessWidget {
  const XecureLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Center(
        child: Image.asset(
          'lib/assets/xecure_logo.png',
          width: 120,
          errorBuilder: (context, error, stackTrace) {
            return Text(
              'Image not found',
              style: TextStyle(color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}

// Helper function to build text fields (normal fields)
Widget _buildTextField(String hintText, IconData icon, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 10, right: 20),
        child: Icon(icon, color: Colors.white70),
      ),
      prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 20),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
  );
}

// Helper function to build dropdowns
Widget _buildDropdown({
  required String hintText,
  required IconData icon,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  String? selectedValue; // Track the selected value

  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 10, right: 20),
        child: Icon(icon, color: Colors.white70),
      ),
      prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 20),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white70), // Hint text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white70), // Border color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white), // Enabled border color
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.white70), // Focused border color
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      filled: true,
      fillColor: Colors.transparent,
    ),
    dropdownColor: Colors.purple.shade700, // Dropdown background color
    style: TextStyle(color: Colors.white, fontSize: 16), // Text style for selected item
    icon: Icon(Icons.arrow_drop_down, color: Colors.white70), // Dropdown icon
    value: selectedValue,
    onChanged: onChanged,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 16), // Text style for dropdown items
        ),
      );
    }).toList(),
  );
}

// Common styles
final headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white);
final subTextStyle = TextStyle(color: Colors.white70);
final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.purple,
  minimumSize: Size(120, 45),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
);