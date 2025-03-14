import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'Health score pages/chemotherapy.dart';
import 'Health score pages/daily_checkup.dart';
import 'Health score pages/diagnosis.dart';
import 'Health score pages/diet_nutrition.dart';
import 'Health score pages/physical_activity.dart';


class HealthScorePage extends StatelessWidget {
  const HealthScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back button and time
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      "12:33",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Box with shadow at the bottom
              Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow only at the bottom
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Health Score Circle
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 12.0,
                        percent: 0.6,
                        center: const Text(
                          "60",
                          style: TextStyle(
                              fontSize: 36.0, fontWeight: FontWeight.bold),
                        ),
                        progressColor: Colors.purple,
                        backgroundColor: Colors.grey[200]!,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      const SizedBox(height: 20),
                      // Description Text
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          "Your health score is calculated based on your activities and medical checkups",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // View Details Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text("View Details",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Update Section
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Menu Items
              _buildMenuItem(
                icon: Icons.medical_services,
                title: "Daily Checkup",
                subtitle: "Enter your daily hospital checkup details",
                onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const DailyCheckupPage()),
                              ),
              ),
              _buildMenuItem(
                icon: Icons.description,
                title: "Diagnosis",
                subtitle: "Enter your diagnosis details",
                onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const DiagnosisPage()),
                              ),
              ),
              _buildMenuItem(
                icon: Icons.local_hospital,
                title: "Chemotherapy",
                subtitle: "Enter your chemotherapy details",
                onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const ChemotherapyPage()),
                              ),
              ),
              _buildMenuItem(
                icon: Icons.bed,
                title: "Sleep Time",
                subtitle: "Enter your sleep time",
                onPressed: () {
                  _showSleepTimeDialog(context); // Show Sleep Time Pop-up
                },
              ),
              _buildMenuItem(
                icon: Icons.fastfood,
                title: "Diet",
                subtitle: "Enter your diet and nutrition",
                onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const DietNutritionPage()),
                              ),
              ),
              _buildMenuItem(
                icon: Icons.fitness_center,
                title: "Physical Activity",
                subtitle: "Enter your today's physical activity",
                onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const PhysicalActivityPage()),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey[600]),
          ),
          title: Text(title),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          trailing: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("View", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  void _showSleepTimeDialog(BuildContext context) {
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController minutesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Sleep Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hours Input
              TextFormField(
                controller: hoursController,
                decoration: const InputDecoration(
                  labelText: 'Hours',
                  hintText: 'e.g., 8',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hours';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Minutes Input
              TextFormField(
                controller: minutesController,
                decoration: const InputDecoration(
                  labelText: 'Minutes',
                  hintText: 'e.g., 30',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter minutes';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Validate and save the data
                if (hoursController.text.isNotEmpty &&
                    minutesController.text.isNotEmpty) {
                  print(
                      'Sleep Time: ${hoursController.text} hours ${minutesController.text} minutes');

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Sleep time saved successfully!')),
                  );

                  // Close the dialog
                  Navigator.pop(context);
                } else {
                  // Show an error message if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter both hours and minutes')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}