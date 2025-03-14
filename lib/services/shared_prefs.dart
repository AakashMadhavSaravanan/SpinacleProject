import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> storePhoneNumber(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phone);
  }

  static Future<String?> getStoredPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone_number');
  }

  // ✅ Make these static for easy access
  static Future<void> storeUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }
}
