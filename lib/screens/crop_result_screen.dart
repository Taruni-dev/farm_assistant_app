import 'package:flutter/material.dart';

class CropResultScreen extends StatelessWidget {
  final String cropName;

  const CropResultScreen({super.key, required this.cropName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Prediction Result"),
        backgroundColor: Color(0xFF90EE90),
      ),
      body: Stack(
        children: [
          // 🌿 Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Green.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🌾 Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "🌾 Best crop to grow: $cropName",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF90EE90), // button color
                    ),
                    child: const Text(
                      "Try Another",
                      style: TextStyle(color: Colors.black), // button text
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
