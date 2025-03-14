import 'package:flutter/material.dart';
import '../health_score.dart';

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  final TextEditingController _diagnosisNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _treatmentPlanController = TextEditingController();

  String? _selectedSeverity;

  // Severity options
  final List<String> _severityOptions = [
    'Mild',
    'Moderate',
    'Severe',
  ];

  void _saveDiagnosisDetails() {
    if (_diagnosisNameController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _symptomsController.text.isEmpty ||
        _treatmentPlanController.text.isEmpty ||
        _selectedSeverity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    // Save the data (for now, just print it)
    print("Diagnosis Name: ${_diagnosisNameController.text}");
    print("Date of Diagnosis: ${_dateController.text}");
    print("Severity: $_selectedSeverity");
    print("Symptoms: ${_symptomsController.text}");
    print("Treatment Plan: ${_treatmentPlanController.text}");

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Diagnosis details saved successfully!')),
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
        title: const Text('Diagnosis'),
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
            // Diagnosis Name
            _buildInputSection(
              label: 'Diagnosis Name',
              hint: 'e.g., Diabetes, Hypertension',
              controller: _diagnosisNameController,
            ),
            const SizedBox(height: 20),

            // Date of Diagnosis
            _buildInputSection(
              label: 'Date of Diagnosis',
              hint: 'e.g., 2023-10-15',
              controller: _dateController,
            ),
            const SizedBox(height: 20),

            // Severity Dropdown
            _buildDropdownSection(
              label: 'Severity',
              hint: 'Select severity',
              value: _selectedSeverity,
              items: _severityOptions,
              onChanged: (value) {
                setState(() {
                  _selectedSeverity = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Symptoms
            _buildInputSection(
              label: 'Symptoms',
              hint: 'e.g., Fatigue, Headache',
              controller: _symptomsController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Treatment Plan
            _buildInputSection(
              label: 'Treatment Plan',
              hint: 'e.g., Medication, Therapy',
              controller: _treatmentPlanController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveDiagnosisDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Diagnosis Details',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
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
          maxLines: maxLines,
        ),
      ],
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
          items: items.map((String severity) {
            return DropdownMenuItem<String>(
              value: severity,
              child: Text(severity),
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

  @override
  void dispose() {
    _diagnosisNameController.dispose();
    _dateController.dispose();
    _symptomsController.dispose();
    _treatmentPlanController.dispose();
    super.dispose();
  }
}