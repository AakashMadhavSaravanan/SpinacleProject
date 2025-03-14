import 'package:flutter/material.dart';
import 'package:flutter_application_1/Profile%20pages/contact_info.dart';
import 'package:flutter_application_1/Profile%20pages/grievance_redressal.dart';
import 'package:flutter_application_1/Profile%20pages/information.dart';
import 'package:flutter_application_1/Profile%20pages/privacy_policy.dart';
import 'package:flutter_application_1/Profile%20pages/regulatory.dart';
import 'package:flutter_application_1/Profile%20pages/terms_conditions.dart';
import 'package:flutter_application_1/Profile%20pages/terms_of_service.dart';
import 'package:flutter_application_1/Profile%20pages/user_dashboard.dart';
import '../Entry Pages/entry_pages.dart';
import 'home.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()), 
                            ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200', // Placeholder profile image
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Gowtham C',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Settings List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  // "Your Account" Label above "Edit Profile"
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Your Account',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InformationForm(),
                        ),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.notifications_outlined,
                    title: 'Contact Info',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.person_outline,
                    title: 'Dashboard',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDashboard(),
                        ),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notification Settings',
                    onTap: () {},
                  ),
                  // "App Settings" Label above "Support"
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Company',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.help_outline,
                    title: 'Regulatory',
                    onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegulatoryComplianceScreen()), 
                            ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.help_outline,
                    title: 'Privacy Policy',
                    onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()), 
                            ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.description_outlined,
                    title: 'Terms of Service',
                    onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => TermsOfServiceScreen()), 
                            ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.help_outline,
                    title: 'Grievance Redressal',
                    onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => GrievanceRedressalScreen()), 
                            ),
                  ),
                  _buildSettingsItem(
                    title: 'Terms and Conditions',
                    icon: Icons.help_outline,
                    onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => TermsConditionsScreen()), 
                            ),
                  ),          
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()), 
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: Icon(icon, color: Colors.grey),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
