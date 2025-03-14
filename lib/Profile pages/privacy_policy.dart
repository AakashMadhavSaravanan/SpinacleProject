import 'package:flutter/material.dart';
import '../../Main Pages/profile.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Plain white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileSettingsScreen()), 
                      ),
        ),
       centerTitle: true,
       title: XecureLogo(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy", style: headerStyle),
              SizedBox(height: 10),
              _buildSection("1. Information We Collect", 
                "We collect the following types of information:\n\n"
                "**1.1 Personal Information**\n"
                "• Name, email address, phone number, and contact details.\n"
                "• Insurance policy details, claims-related documents, and financial data.\n"
                "• Medical history and treatment-related data (only when voluntarily provided).\n\n"
                "**1.2 Non-Personal Information**\n"
                "• Device information, IP address, and browser type.\n"
                "• Website usage patterns and analytics (collected via cookies and tracking technologies).\n"
                "• Aggregated and anonymized health insights.\n\n"
                "**1.3 Financial Information**\n"
                "• Payment details when availing financial assistance through NBFC partners.\n"
                "• Transaction history for insurance claims and medical loans."),
              _buildSection("2. How We Use Your Information", 
                "We use your data for the following purposes:\n\n"
                "• To provide insurance claim support and financial assistance services.\n"
                "• To connect users with partnered hospitals, insurers, and financial institutions.\n"
                "• To enhance user experience through AI-driven health insights and financial recommendations.\n"
                "• To comply with legal, regulatory, and security requirements.\n"
                "• To send transactional updates, alerts, and service notifications.\n"
                "• To improve our services, website functionality, and fraud prevention mechanisms."),
              _buildSection("3. Data Sharing & Third-Party Partners", 
                "We do not sell your personal information. However, we may share data with:\n\n"
                "• **Insurers & NBFCs**: To process insurance claims and financial aid applications.\n"
                "• **Hospitals & Healthcare Providers**: For discounted treatments and medical partnerships.\n"
                "• **Regulatory Authorities**: If required under applicable laws and compliance obligations.\n"
                "• **Technology Partners**: To enhance platform security and improve AI-based analytics.\n\n"
                "All data sharing is governed by strict confidentiality agreements to ensure your privacy and security."),
              _buildSection("4. Data Security & Protection", 
                "We implement robust security measures, including:\n\n"
                "• **End-to-End Encryption (AES-256)** for sensitive data storage and transmission.\n"
                "• **Access Controls & Authentication** to restrict unauthorized access.\n"
                "• **Regular Security Audits** to monitor and strengthen data protection.\n\n"
                "In case of a data breach, affected users will be notified promptly as per legal guidelines."),
              _buildSection("5. Your Rights & Control Over Data", 
                "As a user, you have the right to:\n\n"
                "• **Access & Download** your personal information.\n"
                "• **Request Corrections** to any incorrect data.\n"
                "• **Opt-Out & Withdraw Consent** for non-essential data usage.\n"
                "• **Request Deletion** of your account and personal information (subject to legal and contractual obligations).\n\n"
                "To exercise these rights, please contact us at **care@xecure.in**."),
              _buildSection("6. Cookies & Tracking Technologies", 
                "We use cookies to enhance your browsing experience. You can manage cookie preferences via your browser settings. Blocking cookies may impact certain website functionalities."),
              _buildSection("7. Regulatory Compliance", 
                "We comply with:\n\n"
                "• **India's Digital Personal Data Protection (DPDP) Act**\n"
                "• **IRDAI regulations** for insurance data handling\n"
                "• **RBI guidelines** for financial transactions\n"
                "• **HIPAA & GDPR standards** (where applicable) for handling health-related data"),
              _buildSection("8. Updates to This Privacy Policy", 
                "We may update this Privacy Policy periodically. Changes will be posted on this page with an updated **'Effective Date.'**"),
              _buildSection("9. Contact Us", 
                "For any questions or concerns about this Privacy Policy, please contact:\n\n"
                "📧 **Email**: care@xecure.in\n"
                "📍 **Registered Office**: Spinacle Technologies Private Limited, 1/578 Valayaipathi Salai, Mogappair East, Chennai 600037\n"
                "📞 **Support**: +91 8610244377"),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: subHeaderStyle),
          SizedBox(height: 5),
          Text(content, style: bodyStyle),
        ],
      ),
    );
  }
}

// Xecure Logo Widget
class XecureLogo extends StatelessWidget {
  const XecureLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/xecure_logo_2.png',
      width: 150,
      errorBuilder: (context, error, stackTrace) {
        return Text(
          'Image not found',
          style: TextStyle(color: Colors.red),
        );
      },
    );
  }
}

// Text Styles
final headerStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
final subHeaderStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
final bodyStyle = TextStyle(fontSize: 16, color: Colors.black);
