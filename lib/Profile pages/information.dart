import 'package:flutter/material.dart';

class InformationForm extends StatefulWidget {
  const InformationForm({super.key});

  @override
  _InformationFormState createState() => _InformationFormState();
}

class _InformationFormState extends State<InformationForm> {
  final List<String> diagnosisOptions = [
    'Breast Cancer',
    'Lung Cancer',
    'Colon Cancer',
    'Prostate Cancer',
    'Liver Cancer',
    'Stomach Cancer',
    'Bladder Cancer',
    'Brain Cancer',
    'Blood Cancer',
    'Ovarian Cancer',
    'Others'
  ];

  final List<String> identityOptions = [
    'Caregiver',
    'Patient'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Your Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdownCard(Icons.person, 'Who you are', identityOptions),
            _buildInfoCard(Icons.person, 'Your Name'),
            _buildInfoCard(Icons.cake, 'Age', keyboardType: TextInputType.number),
            _buildInfoCard(Icons.location_on, 'Location'),
            _buildDropdownCard(Icons.medical_services, 'Diagnosis', diagnosisOptions),
            _buildInfoCard(Icons.savings, 'Current Savings', keyboardType: TextInputType.number),
            _buildInfoCard(Icons.attach_money, 'Loan Need', keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: const StadiumBorder(), // Oval button
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Card(
      color: Colors.white, // Ensuring white background
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Double-checking white color
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
                keyboardType: keyboardType,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownCard(IconData icon, String label, List<String> items) {
    return Card(
      color: Colors.white, // Ensuring white background
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Double-checking white color
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: '',
                  border: InputBorder.none,
                ),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
