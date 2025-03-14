import 'package:flutter/material.dart';

class InsuranceClaimPage extends StatelessWidget {
  const InsuranceClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Insurance Claim Tracking & Guidance',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: Icon(Icons.help_outline), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildClaimOptions(),
            SizedBox(height: 20),
            _buildEligibilityCheck(),
            SizedBox(height: 20),
            _buildClaimStatusTracker(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        tooltip: 'Insurance Advisor Chat Support',
        child: Icon(Icons.support_agent, color: Colors.white),
      ),
    );
  }

  Widget _buildClaimOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildOptionCard('Start New Claim', Icons.add_circle_outline)),
        SizedBox(width: 10),
        Expanded(child: _buildOptionCard('Track Existing Claim', Icons.track_changes)),
      ],
    );
  }

  Widget _buildOptionCard(String title, IconData icon) {
    return SizedBox(
      height: 180, // Ensuring both boxes have the same height
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Icon(icon, size: 50, color: Colors.purple),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEligibilityCheck() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI-Based Claim Eligibility Check', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            _buildCustomTextField('Policy Number'),
            _buildCustomTextField('Claim Type'),
            _buildCustomTextField('Claim Amount'),
            _buildCustomTextField('Date of Incident'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(150, 50),
              ),
              child: Text('Check Eligibility', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildClaimStatusTracker() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Claim Status Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Stepper(
                physics: ClampingScrollPhysics(),
                currentStep: 1,
                steps: [
                  Step(title: Text('Claim Submitted'), content: SizedBox.shrink(), isActive: true),
                  Step(title: Text('Documents Verified'), content: SizedBox.shrink(), isActive: true),
                  Step(title: Text('Claim Processing'), content: SizedBox.shrink(), isActive: false),
                  Step(title: Text('Claim Approved'), content: SizedBox.shrink(), isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
