import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_request.dart';

class ApiService {
  // Adjust BASE_URL for emulator/device compatibility
  static const String _localBaseUrl = "http://127.0.0.1:8000"; // Localhost (for web)
  static const String _androidEmulatorBaseUrl = "http://10.0.2.2:8000"; // Android Emulator
  static final String _baseUrl = kIsWeb
      ? _localBaseUrl // Use localhost for web
      : (Platform.isAndroid ? _androidEmulatorBaseUrl : _localBaseUrl);

  // Common POST request method
  static Future<Map<String, dynamic>> _postRequest(String endpoint, Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      throw Exception("Request failed: $e");
    }
  }

  // Fetch data (test API)
  static Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/"));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Request failed: $e";
    }
  }

  // Register user
  static Future<Map<String, dynamic>> registerUser(String phone) async {
  final response = await _postRequest("register/", {"phone": phone});

  if (response["status"] == "success") {
    // Store phone number in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phone);
  }

  return response;
}


  // Verify OTP
  static Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    return await _postRequest("verify/", {"phone": phone, "otp": otp});
  }

  // Resend OTP
  static Future<Map<String, dynamic>> resendOtp(String phone) async {
    return await _postRequest("resend/", {"phone": phone});
  }

  // Create Profile
  static Future<Map<String, dynamic>> createProfile(ProfileRequest profile) async {
  try {
    // Get stored phone number from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phone_number');

    if (phoneNumber == null) {
      throw Exception("Phone number not found in storage");
    }

    // Convert profile to JSON and add phone number
    Map<String, dynamic> profileData = profile.toJson();
    profileData["phone"] = phoneNumber;

    final response = await http.post(
      Uri.parse("$_baseUrl/create-profile/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      // Parse response
      final responseData = jsonDecode(response.body);
      
      // Store the user's name in SharedPreferences
      await prefs.setString('user_name', profile.name);

      return responseData; // Success
    } else {
      throw Exception("Failed to create profile: ${response.body}");
    }
    } catch (e) {
      throw Exception("Request failed: $e");
    }
  }
}