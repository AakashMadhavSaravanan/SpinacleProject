import 'package:flutter/material.dart';
import '../health_score.dart';

class DailyCheckupPage extends StatefulWidget {
  const DailyCheckupPage({super.key});

  @override
  _DailyCheckupPageState createState() => _DailyCheckupPageState();
}

class _DailyCheckupPageState extends State<DailyCheckupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save the data (for now, just print it)
      print("Blood Pressure: ${_bloodPressureController.text}");
      print("Heart Rate: ${_heartRateController.text}");
      print("Temperature: ${_temperatureController.text}");
      print("Notes: ${_notesController.text}");

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkup details saved successfully!')),
      );

      // Optionally, navigate back to the previous page
      Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HealthScorePage()),
                              );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Daily Checkup'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Blood Pressure Field
              TextFormField(
                controller: _bloodPressureController,
                decoration: const InputDecoration(
                  labelText: 'Blood Pressure',
                  hintText: 'e.g., 120/80',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your blood pressure';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Heart Rate Field
              TextFormField(
                controller: _heartRateController,
                decoration: const InputDecoration(
                  labelText: 'Heart Rate',
                  hintText: 'e.g., 72 bpm',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your heart rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Temperature Field
              TextFormField(
                controller: _temperatureController,
                decoration: const InputDecoration(
                  labelText: 'Temperature',
                  hintText: 'e.g., 98.6°F',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your temperature';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Notes Field
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  hintText: 'Enter any additional details',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save Details',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloodPressureController.dispose();
    _heartRateController.dispose();
    _temperatureController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}