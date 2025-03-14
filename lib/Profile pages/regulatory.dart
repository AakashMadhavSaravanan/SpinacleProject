import 'package:flutter/material.dart';
import '../Main Pages/profile.dart';

class RegulatoryComplianceScreen extends StatelessWidget {
  const RegulatoryComplianceScreen({super.key});

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
              Text("Regulatory Compliance & Status", style: headerStyle),
              SizedBox(height: 10),
              _buildSection("1. Xecure™ - A Startup in Validation Phase", 
                "Xecure™, a product of Spinacle Technologies Private Limited, is currently in the validation and trial phase as we work towards developing a robust and compliant platform for cancer care financing, insurance support, and AI-driven treatment insights.\n\n"
                "At this stage, we have not yet commenced full-scale operations and are actively gathering feedback from stakeholders, including patients, healthcare providers, insurers, and financial institutions, to refine our solution."),
              _buildSection("2. Regulatory Approach & Commitment", 
                "We understand that operating in healthcare, insurance, and financial technology requires strict compliance with national and international regulatory frameworks. We are actively assessing regulatory requirements to ensure that Xecure™ aligns with:\n\n"
                "• **Insurance Regulatory and Development Authority of India (IRDAI)** – For compliance related to insurance claim assistance and policy recommendations.\n"
                "• **Reserve Bank of India (RBI)** – For financial assistance services involving NBFC partnerships and loan facilitation.\n"
                "• **Digital Personal Data Protection (DPDP) Act** – For handling patient data securely and ethically.\n"
                "• **Health Insurance Portability and Accountability Act (HIPAA) & GDPR** – If required for data security and privacy measures."),
              _buildSection("3. Current Regulatory Status", 
                "• We have not yet approached regulatory bodies for licenses or approvals.\n"
                "• We are conducting market validation, user trials, and financial feasibility studies.\n"
                "• Our insurance and lending services are currently in a non-commercial prototype stage.\n"
                "• Once we finalize our business model, we will initiate necessary regulatory filings and partnerships."),
              _buildSection("4. Our Commitment to Compliance & Transparency", 
                "• **User Protection**: We are designing Xecure™ to meet legal, ethical, and security standards before a full-scale launch.\n"
                "• **Regulatory Engagement**: We will work with certified financial institutions, insurers, and legal advisors to ensure compliance before operational launch.\n"
                "• **Trial Phase**: All services are currently in an informational and non-transactional phase, with no commercial services being provided."),
              _buildSection("5. Disclaimer", 
                "Xecure™ is in its early stage of development, and no financial, insurance, or medical service is currently active. Any engagements at this stage are strictly for testing, feedback collection, and prototype validation.\n\n"
                "Users and stakeholders engaging with us should acknowledge that:\n\n"
                "• We do not currently provide financial, insurance, or medical services.\n"
                "• Any information on this platform is for research and validation purposes only.\n"
                "• We will update this page once regulatory processes commence."),
              _buildSection("6. Contact Us", 
                "For inquiries regarding our regulatory approach, please contact:\n\n"
                "📧 **Email**: care@xecure.in\n"
                "📍 **Registered Office**: Spinacle Technologies Private Limited, 1/578 Valayapathi Salai, Mogappair East, Chennai-600037\n"
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