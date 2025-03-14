import 'package:flutter/material.dart';
import 'dart:async';
import '../services/api_services.dart'; // Import API service
import 'home.dart'; // Import home page

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String apiResponse = "Fetching data...";

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  // Fetch data from FastAPI
  Future<void> fetchApiData() async {
    String data = await ApiService.fetchData();
    setState(() {
      apiResponse = data;
    });

    // Wait for 3 seconds, then navigate to HomePage
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/cancer_care_black.png',
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(apiResponse), // Display API response
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
