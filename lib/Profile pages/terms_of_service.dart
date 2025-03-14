import 'package:flutter/material.dart';
import '../Main Pages/profile.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
              Text("Terms of Service", style: headerStyle),
              SizedBox(height: 10),
              _buildSection("1. Acceptance of Terms", 
                "By using Xecure™, you acknowledge that you have read, understood, and agree to be bound by these terms. If you do not agree, please do not use our services."),
              _buildSection("2. Services Provided", 
                "Xecure™ provides the following services:\n\n"
                "• Financial Assistance: Access to medical loans and crowdfunding support.\n"
                "• Insurance Support: Guidance on claim processing and policy recommendations.\n"
                "• Treatment Insights: AI-driven health tracking and engagement tools.\n"
                "• Partnered Services: Connections with hospitals, NBFCs, insurers, and NGOs.\n\n"
                "These services are subject to availability, eligibility, and compliance with our policies."),
              _buildSection("3. User Responsibilities", 
                "By using Xecure™, you agree to:\n\n"
                "• Provide accurate and complete information when signing up or requesting services.\n"
                "• Use the platform for lawful and intended purposes only.\n"
                "• Maintain the confidentiality of your account credentials.\n"
                "• Do not engage in any fraudulent, abusive, or unauthorized activities.\n\n"
                "Failure to adhere to these responsibilities may result in suspension or termination of your access."),
              _buildSection("4. Financial & Insurance Disclaimers", 
                "• Xecure™ does not provide loans or insurance policies directly; we facilitate connections with registered NBFCs and insurers.\n"
                "• Approval and processing of financial aid or insurance claims depend on third-party institutions, and Xecure™ is not responsible for their decisions.\n"
                "• Any estimates or AI-based insights provided are informational and not a guarantee of financial approval or claim acceptance."),
              _buildSection("5. Data Privacy & Security", 
                "• We collect, store, and process user data in compliance with applicable laws (see our Privacy Policy for details).\n"
                "• Users retain control over their data and can request modification or deletion as per our data policies.\n"
                "• We implement strict security measures to protect user data but cannot guarantee absolute security against unauthorized access."),
              _buildSection("6. Intellectual Property", 
                "• All content, trademarks, logos, and technology on Xecure™ are owned by Spinacle Technologies Private Limited.\n"
                "• Users may not copy, modify, distribute, or commercially exploit any part of the platform without prior written consent."),
              _buildSection("7. Limitation of Liability", 
                "• Xecure™ and Spinacle Technologies Private Limited are not liable for any direct, indirect, incidental, or consequential damages arising from the use of our services.\n"
                "• We do not guarantee uninterrupted or error-free service and reserve the right to modify, suspend, or discontinue any service at any time."),
              _buildSection("8. Third-Party Links & Services", 
                "• Our platform may contain links to third-party websites, services, or applications.\n"
                "• We do not endorse or assume responsibility for third-party services, and users interact with them at their own risk."),
              _buildSection("9. Changes to Terms", 
                "We may update these Terms of Service from time to time. Changes will be effective upon posting on this page, and continued use of our services constitutes acceptance of the revised terms."),
              _buildSection("10. Governing Law & Dispute Resolution", 
                "• These Terms of Service are governed by the laws of India.\n"
                "• Any disputes shall be resolved through arbitration in Chennai, India, by the Arbitration and Conciliation Act, 1996."),
              _buildSection("11. Contact Information", 
                "For any questions regarding these terms, please contact us:\n\n"
                "📧 **Email**: care@xecure.in\n"
                "📍 **Registered Office**: Spinacle Technologies Private Limited, 1/578 Valaiyapathi Salai, Mogappair East, Chennai - 600037\n"
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
