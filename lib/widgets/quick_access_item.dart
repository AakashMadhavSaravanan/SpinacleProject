import 'package:flutter/material.dart';

class QuickAccessItem extends StatelessWidget {
  final String imageUrl;
  final String label;

  const QuickAccessItem({
    required this.imageUrl,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 60, // Box size
          height: 60, // Box size
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Image.network(
              imageUrl,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator(strokeWidth: 2);
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 40, color: Colors.grey);
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}

class QuickAccessList extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"imageUrl": "https://via.placeholder.com/50", "label": "Pay Bills"},
    {"imageUrl": "https://via.placeholder.com/50", "label": "Policies"},
    {"imageUrl": "https://via.placeholder.com/50", "label": "Reports"},
    {"imageUrl": "https://via.placeholder.com/50", "label": "Q & A"},
    {"imageUrl": "https://via.placeholder.com/50", "label": "Appointments"},
  ];

  QuickAccessList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Set height to fit the items
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Enables sideways swiping
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 16), // Add padding
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12), // Spacing between items
            child: QuickAccessItem(
              imageUrl: items[index]["imageUrl"]!,
              label: items[index]["label"]!,
            ),
          );
        },
      ),
    );
  }
}