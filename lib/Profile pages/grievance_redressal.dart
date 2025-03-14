import 'package:flutter/material.dart';
import '../Main Pages/profile.dart';

class GrievanceRedressalScreen extends StatelessWidget {
  const GrievanceRedressalScreen({super.key});

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
              Text("Grievance Redressal Policy", style: headerStyle),
              SizedBox(height: 10),
              _buildSection("1. Purpose", 
                "This policy ensures that:\n\n"
                "• Users have a clear process to raise grievances related to our services.\n"
                "• Complaints are addressed in a transparent and timely manner.\n"
                "• We maintain accountability and customer satisfaction."),
              _buildSection("2. Scope", 
                "This policy applies to grievances related to:\n\n"
                "• Financial assistance services (loans, crowdfunding, discounts).\n"
                "• Insurance claim processing and policy support.\n"
                "• Treatment insights and AI-driven recommendations.\n"
                "• Platform functionality, security, and accessibility issues.\n"
                "• Privacy, data protection, and misuse of personal information."),
              _buildSection("3. How to Raise a Grievance", 
                "Users can report their concerns through the following channels:\n\n"
                "📌 **Online Submission**\n"
                "• Fill out the Grievance Form on our website: **xecure.in**\n"
                "• Email us at: **care@xecure.in** with details of the issue.\n\n"
                "📌 **Customer Support**\n"
                "• Call our Grievance Helpline at: **+91 8610244377** (Mon-Fri, 10 AM - 6 PM IST)\n"
                "• WhatsApp Support: **+91 8610244377**\n\n"
                "📌 **Written Complaint**\n"
                "Users may send a written complaint to our registered office:\n"
                "**Spinacle Technologies Private Limited, 1/578 Valaiyapathi Salai, Mogappair East, Chennai-600037**"),
              _buildSection("4. Grievance Resolution Process", 
                "Upon receiving a grievance, we will:\n\n"
                "• Acknowledge the complaint within **24 hours**.\n"
                "• Investigate and assess the issue with the relevant department.\n"
                "• Provide a resolution or response within **7 working days**.\n"
                "• If further action is required, update the user on the expected resolution timeline.\n"
                "• If a user is not satisfied with the resolution, they may escalate the matter to our Grievance Officer."),
              _buildSection("5. Grievance Officer Details", 
                "As per regulatory requirements, we have appointed a Grievance Officer to handle escalated complaints.\n\n"
                "📌 **Grievance Officer**: Santhosh Kumar E, Founder and COO\n"
                "📧 **Email**: founder@spinacle.net\n"
                "📍 **Address**: Spinacle Technologies Private Limited, 1/578 Valaiyapathi Salai, Mogappair East, Chennai-600037\n"
                "📞 **Contact**: +91 8610244377"),
              _buildSection("6. Escalation & Regulatory Compliance", 
                "If your concern remains unresolved, you may escalate your complaint to the following authorities:\n\n"
                "• **Insurance Regulatory and Development Authority of India (IRDAI)** – For insurance-related issues.\n"
                "• **Reserve Bank of India (RBI)** – For financial services-related concerns.\n"
                "• **Data Protection Authority of India** – For privacy and data security complaints."),
              _buildSection("7. Review & Updates", 
                "This Grievance Redressal Policy is reviewed periodically to ensure compliance with legal regulations and maintain the highest standard of service."),
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