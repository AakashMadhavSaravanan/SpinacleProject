import 'package:flutter/material.dart';
import '../health_score.dart';

class ChemotherapyPage extends StatefulWidget {
  const ChemotherapyPage({super.key});

  @override
  _ChemotherapyPageState createState() => _ChemotherapyPageState();
}

class _ChemotherapyPageState extends State<ChemotherapyPage> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _dosagePerSessionController = TextEditingController();
  final TextEditingController _numberOfSessionsController = TextEditingController();
  final TextEditingController _totalDosageController = TextEditingController();
  final TextEditingController _sideEffectsController = TextEditingController();

  void _calculateTotalDosage() {
    if (_dosagePerSessionController.text.isEmpty ||
        _numberOfSessionsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill dosage and number of sessions!')),
      );
      return;
    }

    // Get inputs
    double dosagePerSession = double.parse(_dosagePerSessionController.text);
    int numberOfSessions = int.parse(_numberOfSessionsController.text);

    // Calculate total dosage
    double totalDosage = dosagePerSession * numberOfSessions;

    // Update the total dosage field
    setState(() {
      _totalDosageController.text = totalDosage.toStringAsFixed(2);
    });
  }

  void _saveChemotherapyDetails() {
    if (_typeController.text.isEmpty ||
        _dosagePerSessionController.text.isEmpty ||
        _numberOfSessionsController.text.isEmpty ||
        _totalDosageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields!')),
      );
      return;
    }

    // Save the data (for now, just print it)
    print("Chemotherapy Type: ${_typeController.text}");
    print("Dosage Per Session: ${_dosagePerSessionController.text} mg");
    print("Number of Sessions: ${_numberOfSessionsController.text}");
    print("Total Dosage: ${_totalDosageController.text} mg");
    print("Side Effects: ${_sideEffectsController.text}");

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chemotherapy details saved successfully!')),
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
        title: const Text('Chemotherapy'),
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
            // Chemotherapy Type
            _buildInputSection(
              label: 'Chemotherapy Type',
              hint: 'e.g., Paclitaxel, Cisplatin',
              controller: _typeController,
            ),
            const SizedBox(height: 20),

            // Dosage Per Session
            _buildInputSection(
              label: 'Dosage Per Session (mg)',
              hint: 'e.g., 100',
              controller: _dosagePerSessionController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Number of Sessions
            _buildInputSection(
              label: 'Number of Sessions',
              hint: 'e.g., 5',
              controller: _numberOfSessionsController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Total Dosage (Read-only)
            _buildInputSection(
              label: 'Total Dosage (mg)',
              hint: 'Calculated total dosage will appear here',
              controller: _totalDosageController,
              readOnly: true,
            ),
            const SizedBox(height: 20),

            // Calculate Total Dosage Button
            ElevatedButton(
              onPressed: _calculateTotalDosage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Calculate Total Dosage',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Side Effects
            _buildInputSection(
              label: 'Side Effects',
              hint: 'e.g., Nausea, Fatigue',
              controller: _sideEffectsController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveChemotherapyDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Chemotherapy Details',
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
    TextInputType? keyboardType,
    bool readOnly = false,
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
          keyboardType: keyboardType,
          readOnly: readOnly,
          maxLines: maxLines,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _typeController.dispose();
    _dosagePerSessionController.dispose();
    _numberOfSessionsController.dispose();
    _totalDosageController.dispose();
    _sideEffectsController.dispose();
    super.dispose();
  }
}