import 'package:flutter/material.dart';
import 'chatbot.dart';

class AIHealthEngagementPage extends StatelessWidget {
  const AIHealthEngagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'AI-Driven Health Engagement',
          style: TextStyle(fontWeight: FontWeight.bold), // Bold title
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Medication Reminders
            _buildSection(
              title: 'Medication Reminders',
              icon: Icons.medication,
              content: 'Get push notifications & SMS reminders for your medications.',
              onTap: () {
                // Handle medication reminders
              },
            ),
            SizedBox(height: 20),

            // Checkup Scheduling Reminders
            _buildSection(
              title: 'Checkup Scheduling Reminders',
              icon: Icons.calendar_today,
              content: 'Reminders for doctor visits, lab tests, and follow-ups.',
              onTap: () {
                // Handle checkup reminders
              },
            ),
            SizedBox(height: 20),

            // AI Chatbot for Basic Consultations
            _buildSection(
              title: 'AI Chatbot for Basic Consultations',
              icon: Icons.chat,
              content: 'Ask FAQs on cancer care, finance, and insurance.',
              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const XecureChatApp()),
              )
            ),
            SizedBox(height: 20),

            // Rewards for Adherence
            _buildSection(
              title: 'Rewards for Adherence',
              icon: Icons.emoji_events,
              content: 'Earn discounts & financial benefits for proactive health engagement.',
              onTap: () {
                // Handle rewards
              },
            ),
            SizedBox(height: 20),

            // Gamification: Points for Completing Tasks
            _buildGamificationSection(),
          ],
        ),
      ),
    );
  }

  // Section Widget
  Widget _buildSection({
    required String title,
    required IconData icon,
    required String content,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.purple),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      content,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Gamification Section Widget
  Widget _buildGamificationSection() {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gamification: Earn Points for Completing Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTaskItem(
                  icon: Icons.medication,
                  task: 'Take Medication',
                  points: '+10 Points',
                ),
                _buildTaskItem(
                  icon: Icons.calendar_today,
                  task: 'Attend Checkup',
                  points: '+20 Points',
                ),
                _buildTaskItem(
                  icon: Icons.chat,
                  task: 'Chat with AI',
                  points: '+5 Points',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Task Item Widget
  Widget _buildTaskItem({
    required IconData icon,
    required String task,
    required String points,
  }) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.purple),
        SizedBox(height: 8),
        Text(
          task,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          points,
          style: TextStyle(fontSize: 12, color: Colors.green),
        ),
      ],
    );
  }
}