import 'package:flutter/material.dart';



class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'User Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold), // Make heading bold
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Financial Aid Progress
            _buildSection(
              context,
              title: 'Financial Aid Progress',
              icon: Icons.attach_money,
              children: [
                _buildProgressItem('Loans', '75%'),
                _buildProgressItem('Insurance', '50%'),
                _buildProgressItem('Crowdfunding Status', '90%'),
              ],
            ),
            SizedBox(height: 20),

            // Health & Treatment Progress
            _buildSection(
              context,
              title: 'Health & Treatment Progress',
              icon: Icons.health_and_safety,
              children: [
                _buildProgressItem('Doctor Visits', '4/6 completed'),
                _buildProgressItem('Medication Adherence', '85%'),
              ],
            ),
            SizedBox(height: 20),

            // Pending Actions & Alerts
            _buildSection(
              context,
              title: 'Pending Actions & Alerts',
              icon: Icons.notifications_active,
              children: [
                _buildAlertItem('Documents Needed', 'Upload insurance documents'),
                _buildAlertItem('Insurance Status Update', 'Renew by 30th Oct'),
              ],
            ),
            SizedBox(height: 20),

            // Community & Support Groups
            _buildSection(
              context,
              title: 'Community & Support Groups',
              icon: Icons.people,
              children: [
                _buildCommunityItem('Join Patient Networks', 'Connect with others'),
                _buildCommunityItem('NGO Forums', 'Explore NGO support'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Section Widget
  Widget _buildSection(BuildContext context, {required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        border: Border.all(color: Colors.grey.shade300), // Grey border
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: Colors.purple), // Use primary color for icons
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  // Progress Item Widget
  Widget _buildProgressItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Alert Item Widget
  Widget _buildAlertItem(String title, String description) {
    return ListTile(
      leading: Icon(Icons.warning, color: Colors.orange),
      title: Text(title, style: TextStyle(fontSize: 16)),
      subtitle: Text(description, style: TextStyle(fontSize: 14)),
      onTap: () {
        // Handle alert tap
      },
    );
  }

  // Community Item Widget
  Widget _buildCommunityItem(String title, String description) {
    return ListTile(
      leading: Icon(Icons.group, color: Colors.green),
      title: Text(title, style: TextStyle(fontSize: 16)),
      subtitle: Text(description, style: TextStyle(fontSize: 14)),
      onTap: () {
        // Handle community item tap
      },
    );
  }
}