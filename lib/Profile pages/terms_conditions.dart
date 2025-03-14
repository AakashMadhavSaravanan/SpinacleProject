import 'package:flutter/material.dart';
import '../../Main Pages/profile.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
        title: XecureLogo(), // Xecure logo at the top
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Terms & Conditions", style: headerStyle),
              SizedBox(height: 10),
              _buildSection("Welcome to Xecure™", 
                "These Terms & Conditions outline the rules, requirements, and policies governing your use of our website, mobile application, and services.\n\n"
                "By accessing or using Xecure™, you agree to comply with these terms. If you do not agree, please do not use our services."),
              _buildSection("1. Eligibility", 
                "To use Xecure™, you must:\n\n"
                "• Be at least **18 years old** or have parental/guardian consent.\n"
                "• Provide **accurate and truthful information** when signing up.\n"
                "• Not engage in **fraudulent or unlawful activities**."),
              _buildSection("2. Account Registration & Responsibilities", 
                "• Users must create an account to access financial assistance, insurance services, and treatment insights.\n"
                "• You are responsible for maintaining the confidentiality of your account credentials.\n"
                "• We reserve the right to suspend or terminate accounts found violating our policies."),
              _buildSection("3. Service Use & Restrictions", 
                "By using Xecure™, you agree that you will not:\n\n"
                "• Use the platform for any **unauthorized or illegal activities**.\n"
                "• Attempt to **disrupt, hack, or compromise** our security systems.\n"
                "• Submit **false insurance claims, financial requests, or misleading health information**.\n"
                "• Use **automated systems, bots, or scripts** to interact with our platform."),
              _buildSection("4. Payments & Transactions", 
                "• Financial assistance services (loans, crowdfunding, discounts) are facilitated through third-party partners.\n"
                "• Insurance services involve claim assistance and policy navigation, but Xecure™ does not directly provide insurance.\n"
                "• Payments processed via our platform comply with **RBI and IRDAI regulations**.\n"
                "• Any refund, cancellation, or dispute must be resolved through the respective partner institution."),
              _buildSection("5. Limitation of Liability", 
                "• Xecure™ does not guarantee **financial assistance** or **insurance claim approval**, as these depend on third-party institutions.\n"
                "• We are **not liable for medical, financial, or insurance decisions** made by users or partner organizations.\n"
                "• We do not provide **medical advice**; all health-related information is for educational purposes only."),
              _buildSection("6. Privacy & Data Protection", 
                "• Your personal and medical information is securely stored and processed in compliance with **India’s DPDP Act, IRDAI, RBI, and HIPAA regulations**.\n"
                "• We do **not sell or misuse your data** but may share it with third-party partners for service fulfillment.\n"
                "• Read our **Privacy Policy** to understand how we collect, store, and use your information."),
              _buildSection("7. Third-Party Links & Services", 
                "• Xecure™ may provide access to third-party **websites, insurers, NBFCs, and healthcare providers**.\n"
                "• We do **not control or endorse third-party services**, and users engage with them at their own risk."),
              _buildSection("8. Modifications to Services & Terms", 
                "• We reserve the right to **update, modify, or discontinue** any part of our services at any time.\n"
                "• Updates to these terms will be posted on this page, and continued use of Xecure™ constitutes acceptance of revised terms."),
              _buildSection("9. Governing Law & Dispute Resolution", 
                "• These Terms & Conditions are governed by the **laws of India**.\n"
                "• Any disputes shall be resolved through **arbitration in Chennai, India**, in accordance with the **Arbitration and Conciliation Act, 1996**."),
              _buildSection("10. Contact Information", 
                "📧 **Email**: care@xecure.in\n"
                "📍 **Registered Office**: Spinacle Technologies Private Limited, 1/578, Valaiyapathi Salai, Mogappair East, Chennai-600037\n"
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
