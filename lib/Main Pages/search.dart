import 'package:flutter/material.dart'; // Import main.dart to access MainPage

class MedicalSearchPage extends StatefulWidget {
  const MedicalSearchPage({super.key});

  @override
  State<MedicalSearchPage> createState() => _MedicalSearchPageState();
}

class _MedicalSearchPageState extends State<MedicalSearchPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'Hospitals',
    'Medical loan',
    'Insurance Policies',
    'NGO',
    'Pharmacy',
    'Doctors',
    'Emergency'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  
                  const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.location_on_outlined),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search.....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: _categories.map((category) {
                  final isSelected = _categories.indexOf(category) == _selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedIndex = _categories.indexOf(category);
                        });
                      },
                      selectedColor: Colors.purple[100],
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.purple : Colors.grey[300]!,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Content
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildHospitalsList(),
                  _buildMedicalLoanList(),
                  const Center(child: Text('Insurance Policies')),
                  const Center(child: Text('NGO')),
                  const Center(child: Text('Pharmacy')),
                  const Center(child: Text('Doctors')),
                  const Center(child: Text('Emergency')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHospitalCard(
          name: 'One Health Clinic',
          specialty: 'Multispeciality',
          rating: 4.8,
          reviews: '1k+',
          address: '7/126, 54th Street Sidco Nagar, Villivakkam, Chennai',
          duration: '10 min',
          distance: '1.2 km',
          imageUrl: 'https://t3.ftcdn.net/jpg/02/96/74/64/360_F_296746476_F0wDElEXSb0Rd1tyDnsCBLVBHGAsJm3O.jpg',
        ),
        const SizedBox(height: 16),
        _buildHospitalCard(
          name: 'Cancer Proton Hospital',
          specialty: 'Multispeciality',
          rating: 4.8,
          reviews: '1k+',
          address: '6/16, 4th Street Anna Nagar, Chennai',
          duration: '5 min',
          distance: '0.8 km',
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRygYOQi3wYpaSyVBxywDKl4ef2GA6GMww39Q&s',
        ),
      ],
    );
  }

  Widget _buildHospitalCard({
    required String name,
    required String specialty,
    required double rating,
    required String reviews,
    required String address,
    required String duration,
    required String distance,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$rating ($reviews)',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      distance,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalLoanList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildLoanCard(
          name: 'Ayush Medical Loan',
          type: 'Cancer Care Loans',
          interest: 'Starting at 4% p.a',
          amount: '₹50,000 - ₹10,00,000',
          tenure: 'Flexible tenure: 6 months- 5 years',
        ),
        const SizedBox(height: 16),
        _buildLoanCard(
          name: 'Nexus Health Credit',
          type: 'Cancer Care Loans',
          interest: 'Starting at 5% p.a',
          amount: '₹50,000 - ₹10,00,000',
          tenure: 'Flexible tenure: 6 months- 5 years',
        ),
        const SizedBox(height: 16),
        _buildLoanCard(
          name: 'SMCG Credit',
          type: 'Cancer Care Loans',
          interest: 'Starting at 4.5% p.a',
          amount: '₹50,000 - ₹10,00,000',
          tenure: 'Flexible tenure: 6 months- 5 years',
        ),
      ],
    );
  }

  Widget _buildLoanCard({
    required String name,
    required String type,
    required String interest,
    required String amount,
    required String tenure,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_hospital,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildLoanDetail(Icons.percent, interest),
            const SizedBox(height: 8),
            _buildLoanDetail(Icons.currency_rupee, amount),
            const SizedBox(height: 8),
            _buildLoanDetail(Icons.access_time, tenure),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.purple,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}