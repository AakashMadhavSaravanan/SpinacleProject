import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Assistance pages/financial_assistance.dart';
import '../Assistance pages/insurance_claim.dart';
import '../Assistance pages/health_score.dart';

class HealthcareSupportScreen extends StatelessWidget {
  const HealthcareSupportScreen({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header inside a box with only bottom shadow (No border)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4), // Shadow at bottom
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Financial and Insurance support\nfor better healthcare',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
            ),

            // **Main content centered vertically between header and footer**
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center between header & footer
                children: [
                  GestureDetector(
                    onTap: () => _navigateTo(context, FinancialAssistancePage()),
                    child: const _SupportCard(
                      iconColor: Color(0xFF1E88E5),
                      icon: Icons.attach_money,
                      title: 'Empowering your\nfinancial support',
                    ),
                  ),
                  const SizedBox(height: 14),

                  GestureDetector(
                    onTap: () => _navigateTo(context, InsuranceClaimPage()),
                    child: const _SupportCard(
                      iconColor: Color(0xFF26A69A),
                      icon: Icons.shield,
                      title: 'Simplifying\ninsurance claims',
                    ),
                  ),
                  const SizedBox(height: 14),

                  GestureDetector(
                    onTap: () => _navigateTo(context, HealthScorePage()),
                    child: Container(
                      width: 360,
                      height: 115,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 4.0,
                            percent: 0.5,
                            center: const Text(
                              "50%",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            progressColor: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.2),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Your\nHealth Score',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer-like bottom spacing to maintain structure
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String title;

  const _SupportCard({
    required this.iconColor,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 115,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
