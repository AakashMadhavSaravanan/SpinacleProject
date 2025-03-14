import 'package:flutter/material.dart';
import 'entry_pages.dart';
import '../Main Pages/home.dart';

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

// Registration Screen
class RegistrationScreenFP extends StatelessWidget {
  const RegistrationScreenFP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()), 
                            ), 
                    ),
                    Expanded(child: XecureLogo()),
                  ],
                ),
              ),
              SizedBox(height: 10), // Moves content upwards
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Forgot Password', style: headerStyle),
                        Text('Enter your email or phone number to continue', style: subTextStyle),
                        SizedBox(height: 20),
                        _buildTextField('Email or phone number'),
                        SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreenFP()));
                            },
                            style: buttonStyle,
                            child: Text('Get OTP', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Verification Screen
class VerificationScreenFP extends StatelessWidget {
  const VerificationScreenFP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(child: XecureLogo()),
                  ],
                ),
              ),
              SizedBox(height: 10), // Moves content upwards
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Verification', style: headerStyle),
                        Text('Enter the OTP sent', style: subTextStyle),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) => _buildOtpBox()),
                        ),
                        SizedBox(height: 24),
                        TextButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreenFP()));},
                          child: Text('Wrong email or phone no?', style: TextStyle(color: Colors.white)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.refresh, color: Colors.white),
                              label: Text('Resend', style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()), 
                              ),
                              style: buttonStyle,
                              child: Text('Verify', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class XecureLogo extends StatelessWidget {
  const XecureLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Image.asset(
          'lib/assets/xecure_logo.png',
          width: 150,
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

// Helper function to build text fields
Widget _buildTextField(String hintText, {bool obscureText = false, String prefixText = ''}) {
  return TextField(
    obscureText: obscureText,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixText: prefixText,
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

// Helper function to build OTP boxes
Widget _buildOtpBox() {
  return SizedBox(
    width: 45,
    height: 45,
    child: TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        counterText: "",
      ),
    ),
  );
}

final headerStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
final subTextStyle = TextStyle(color: Colors.white70);
final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.purple,
  minimumSize: Size(100, 45),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
);
