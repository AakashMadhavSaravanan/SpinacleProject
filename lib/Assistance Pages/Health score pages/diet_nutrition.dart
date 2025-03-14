import 'package:flutter/material.dart';
import '../health_score.dart';

class DietNutritionPage extends StatefulWidget {
  const DietNutritionPage({super.key});

  @override
  _DietNutritionPageState createState() => _DietNutritionPageState();
}

class _DietNutritionPageState extends State<DietNutritionPage> {
  final TextEditingController _breakfastController = TextEditingController();
  final TextEditingController _morningSnackController = TextEditingController();
  final TextEditingController _lunchController = TextEditingController();
  final TextEditingController _eveningSnackController = TextEditingController();
  final TextEditingController _dinnerController = TextEditingController();

  void _saveDietDetails() {
    // Save the data (for now, just print it)
    print("Breakfast: ${_breakfastController.text}");
    print("Morning Snack: ${_morningSnackController.text}");
    print("Lunch: ${_lunchController.text}");
    print("Evening Snack: ${_eveningSnackController.text}");
    print("Dinner: ${_dinnerController.text}");

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Diet details saved successfully!')),
    );

    // Optionally, navigate back to the previous page
    Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HealthScorePage()),
                              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Diet and Nutrition'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HealthScorePage()),
                              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Breakfast
            _buildMealSection(
              label: 'Breakfast',
              hint: 'e.g., Oatmeal with fruits',
              controller: _breakfastController,
            ),
            const SizedBox(height: 20),

            // Morning Snack
            _buildMealSection(
              label: 'Morning Snack',
              hint: 'e.g., Apple with peanut butter',
              controller: _morningSnackController,
            ),
            const SizedBox(height: 20),

            // Lunch
            _buildMealSection(
              label: 'Lunch',
              hint: 'e.g., Grilled chicken with vegetables',
              controller: _lunchController,
            ),
            const SizedBox(height: 20),

            // Evening Snack
            _buildMealSection(
              label: 'Evening Snack',
              hint: 'e.g., Yogurt with granola',
              controller: _eveningSnackController,
            ),
            const SizedBox(height: 20),

            // Dinner
            _buildMealSection(
              label: 'Dinner',
              hint: 'e.g., Salmon with quinoa',
              controller: _dinnerController,
            ),
            const SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: _saveDietDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Diet Details',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealSection({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _breakfastController.dispose();
    _morningSnackController.dispose();
    _lunchController.dispose();
    _eveningSnackController.dispose();
    _dinnerController.dispose();
    super.dispose();
  }
}