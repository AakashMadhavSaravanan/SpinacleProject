import 'package:flutter/material.dart';
import '../health_score.dart';

class PhysicalActivityPage extends StatefulWidget {
  const PhysicalActivityPage({super.key});

  @override
  _PhysicalActivityPageState createState() => _PhysicalActivityPageState();
}

class _PhysicalActivityPageState extends State<PhysicalActivityPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  String? _selectedActivity;
  double? _metValue;

  // MET values for different activities
  final Map<String, double> _activityMetValues = {
    'Running': 8.0,
    'Cycling': 7.5,
    'Swimming': 6.0,
    'Yoga': 3.0,
    'Weight Lifting': 6.0,
    'Walking': 4.0,
  };

  void _calculateCaloriesBurned() {
    if (_selectedActivity == null ||
        _weightController.text.isEmpty ||
        _durationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    // Get inputs
    double weight = double.parse(_weightController.text);
    double duration = double.parse(_durationController.text);

    // Convert duration to hours
    double durationInHours = duration / 60;

    // Calculate calories burned
    double caloriesBurned = _metValue! * weight * durationInHours;

    // Update the calories burned field
    setState(() {
      _caloriesController.text = caloriesBurned.toStringAsFixed(2);
    });
  }

  void _saveActivityDetails() {
    if (_caloriesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please calculate calories burned first!')),
      );
      return;
    }

    // Save the data (for now, just print it)
    print("Activity: $_selectedActivity");
    print("Weight: ${_weightController.text} kg");
    print("Duration: ${_durationController.text} minutes");
    print("Calories Burned: ${_caloriesController.text}");

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Activity details saved successfully!')),
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
        title: const Text('Physical Activity'),
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
            // Activity Dropdown
            _buildDropdownSection(
              label: 'Activity',
              hint: 'Select an activity',
              value: _selectedActivity,
              items: _activityMetValues.keys.toList(),
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value;
                  _metValue = _activityMetValues[value];
                });
              },
            ),
            const SizedBox(height: 20),

            // Weight Input
            _buildInputSection(
              label: 'Weight (kg)',
              hint: 'e.g., 70',
              controller: _weightController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Duration Input
            _buildInputSection(
              label: 'Duration (minutes)',
              hint: 'e.g., 30',
              controller: _durationController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Calories Burned (Read-only)
            _buildInputSection(
              label: 'Calories Burned',
              hint: 'Calculated calories will appear here',
              controller: _caloriesController,
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Calculate Button
            ElevatedButton(
              onPressed: _calculateCaloriesBurned,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Calculate Calories Burned',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveActivityDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Activity Details',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSection({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
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
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),
          items: items.map((String activity) {
            return DropdownMenuItem<String>(
              value: activity,
              child: Text(activity),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildInputSection({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool readOnly = false,
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
          keyboardType: keyboardType,
          readOnly: readOnly,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}