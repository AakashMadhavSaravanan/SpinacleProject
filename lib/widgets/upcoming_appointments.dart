import 'package:flutter/material.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointments = [
      {
        'doctor': 'Dr. John Doe',
        'time': '3 PM',
        'location': 'New York, NY',
        'image':
            'https://static.vecteezy.com/system/resources/thumbnails/026/375/249/small_2x/ai-generative-portrait-of-confident-male-doctor-in-white-coat-and-stethoscope-standing-with-arms-crossed-and-looking-at-camera-photo.jpg',
      },
      {
        'doctor': 'Dr. Jane Smith',
        'time': '5 PM',
        'location': 'Los Angeles, CA',
        'image':
            'https://media.istockphoto.com/id/638647058/photo/we-offer-our-patients-premium-healthcare-here.jpg?s=612x612&w=0&k=20&c=pek5ehwgsZNPemeEh4bObQ1U5DRPEs0WHleosG-daa8=',
      },
      {
        'doctor': 'Dr. Alex Brown',
        'time': '7 PM',
        'location': 'Chicago, IL',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRtcAdqTgmM7vV8XEkpGumjp0Mcg4TsjTBPQ&s',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Book Appointments',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 322,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppointmentCard(
                  doctor: appointment['doctor']!,
                  time: appointment['time']!,
                  location: appointment['location']!,
                  imageUrl: appointment['image']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctor;
  final String time;
  final String location;
  final String imageUrl;

  const AppointmentCard({
    super.key,
    required this.doctor,
    required this.time,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              width: 215,
              height: 140,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 215,
                  height: 140,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 215,
                  height: 140,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Text(
              doctor,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4), // Reduced space
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Book an appointment at $time.',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4), // Reduced space
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.purple,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 12),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement booking functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}