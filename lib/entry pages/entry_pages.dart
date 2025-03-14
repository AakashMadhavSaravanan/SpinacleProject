import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'profile_creation.dart';
import '../Main Pages/home.dart';
import '../services/api_services.dart';  // Import API service for registration & verification

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
          colors: [Colors.purple.shade700, Colors.black],
        ),
      ),
      child: child,
    );
  }
}

// Registration Screen
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    // Validate phone number
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your phone number")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call the API to register the user
      final response = await ApiService.registerUser(_phoneController.text);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP sent: ${response['otp']}")), // For testing only
      );

      // Navigate to the verification page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(phone: _phoneController.text),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Fixed Xecure Logo
              const XecureLogo(),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Registration', style: headerStyle),
                        Text('Enter your phone number to continue', style: subTextStyle),
                        const SizedBox(height: 20),
                        _buildTextField(
                          'Enter your phone number',
                          prefixText: '+91  ',
                          controller: _phoneController,
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _registerUser,
                            style: buttonStyle,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text('Get OTP', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        // Footer (scrolls with content)
                        _buildFooter(
                          context,
                          'Already have an account?',
                          ' Login here',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
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
class VerificationScreen extends StatefulWidget {
  final String phone;

  const VerificationScreen({super.key, required this.phone});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  bool _isLoading = false;
  bool _isResending = false;

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Combine OTP digits into a single string
      final otp = _otpControllers.map((controller) => controller.text).join();

      // Validate OTP length
      if (otp.length != 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
        );
        return;
      }

      // Call the API to verify the OTP
      final response = await ApiService.verifyOtp(widget.phone, otp);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );

      // Navigate to the profile creation page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileCreationScreen()),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResending = true;
    });

    try {
      // Call the API to resend the OTP
      final response = await ApiService.resendOtp(widget.phone);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("New OTP sent: ${response['otp']}")), // For testing only
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Fixed Xecure Logo
              const XecureLogo(),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text('Verification', style: headerStyle),
                        Text('Enter the OTP sent', style: subTextStyle),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            6,
                            (index) => _buildOtpBox(_otpControllers[index]),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () {
                            // Clear the phone number controller before navigating back
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationScreen(),
                              ),
                            ).then((_) {
                              // Clear the OTP fields when navigating back
                              for (var controller in _otpControllers) {
                                controller.clear();
                              }
                            });
                          },
                          child: const Text('Wrong number?', style: TextStyle(color: Colors.white)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: _isResending ? null : _resendOtp,
                              icon: const Icon(Icons.refresh, color: Colors.white),
                              label: _isResending
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('Resend', style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _verifyOtp,
                              style: buttonStyle,
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('Verify', style: TextStyle(color: Colors.white)),
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

// Helper function to build OTP boxes
Widget _buildOtpBox(TextEditingController controller) {
  return SizedBox(
    width: 45,
    height: 45,
    child: TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        counterText: "",
      ),
    ),
  );
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Fixed Xecure Logo
              const XecureLogo(),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back!', style: headerStyle),
                        Text('Login using your email or phone number', style: subTextStyle),
                        const SizedBox(height: 24),
                        _buildTextField('Enter your email or phone number'),
                        const SizedBox(height: 16),
                        TextField(
                          obscureText: _obscurePassword,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const RegistrationScreenFP()),
                              ),
                              child: const Text('Forgot password?', style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HomePage()),
                              ),
                              style: buttonStyle,
                              child: const Text('Login', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        // Footer (scrolls with content)
                        _buildFooter(
                          context,
                          'New here?',
                          ' Register now',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                            );
                          },
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

// Logo widget
class XecureLogo extends StatelessWidget {
  const XecureLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Image.asset(
          'lib/assets/xecure_logo.png',
          width: 150,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
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
Widget _buildTextField(String hintText, {bool obscureText = false, String prefixText = '', TextEditingController? controller}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixText: prefixText,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
  );
}

// Helper function to build footers
Widget _buildFooter(BuildContext context, String text, String actionText, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Center(
      child: TextButton(
        onPressed: onPressed,
        child: RichText(
          text: TextSpan(
            text: text,
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: actionText,
                style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Common styles
final headerStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
final subTextStyle = TextStyle(color: Colors.white70);
final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.purple,
  minimumSize: const Size(100, 45),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
);