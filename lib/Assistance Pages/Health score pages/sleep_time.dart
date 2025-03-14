import 'package:flutter/material.dart';

class SleepTimePage extends StatelessWidget {
  const SleepTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showSleepTimeDialog(context);
          },
          child: const Text('Enter Sleep Time'),
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