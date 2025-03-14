import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
      home: FinancialAssistancePage(),
    );
  }
}

class FinancialAssistancePage extends StatelessWidget {
  const FinancialAssistancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light grey background for contrast
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Medical Loan & Crowdfunding',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.help_outline, color: Colors.black), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoanOptions(),
            SizedBox(height: 20),
            _buildEligibilityCalculator(),
            SizedBox(height: 20),
            _buildLoanStatusTracker(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        tooltip: 'Customer Support',
        child: Icon(Icons.support_agent, color: Colors.white),
      ),
    );
  }

  Widget _buildLoanOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildOptionCard('Apply for Medical Loan', Icons.account_balance)),
        SizedBox(width: 10),
        Expanded(child: _buildOptionCard('Start a Crowdfunding Campaign', Icons.volunteer_activism)),
      ],
    );
  }

  Widget _buildOptionCard(String title, IconData icon) {
    return SizedBox(
      height: 180,
      child: Card(
        color: Colors.white, // White background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _buildEligibilityCalculator() {
    return Card(
      color: Colors.white, // White background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan Eligibility Calculator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            _buildCustomTextField('Age'),
            _buildCustomTextField('Income'),
            _buildCustomTextField('Medical Condition'),
            _buildCustomTextField('Loan Amount'),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: Size(150, 50),
                ),
                child: Text('Check Eligibility', style: TextStyle(color: Colors.white)),
              ),
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
          filled: true,
          fillColor: Colors.white, // White background for text field
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildLoanStatusTracker() {
    return Card(
      color: Colors.white, // White background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan Status Tracker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            Stepper(
              physics: NeverScrollableScrollPhysics(),
              currentStep: 1,
              steps: [
                Step(title: Text('Application Submitted'), content: SizedBox.shrink(), isActive: true),
                Step(title: Text('Documents Verified'), content: SizedBox.shrink(), isActive: true),
                Step(title: Text('Loan Approved'), content: SizedBox.shrink(), isActive: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
