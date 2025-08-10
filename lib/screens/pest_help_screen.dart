// File: pest_help_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'pest_result_screen.dart';

class PestHelpScreen extends StatefulWidget {
  const PestHelpScreen({super.key});

  @override
  State<PestHelpScreen> createState() => _PestHelpScreenState();
}

class _PestHelpScreenState extends State<PestHelpScreen> {
  final TextEditingController cropController = TextEditingController();
  final TextEditingController issueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/Green.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🐛 Pest Help',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: cropController,
                    hint: "Enter crop name",
                    icon: Icons.eco,
                    iconColor: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: issueController,
                    hint: "Describe pest/disease issue",
                    icon: Icons.warning,
                    iconColor: Colors.amber,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      final crop = cropController.text.trim();
                      final issue = issueController.text.trim();

                      if (crop.isEmpty || issue.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please fill in both fields")),
                        );
                        return;
                      }

                      handlePestSearch(crop, issue);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF90EE90),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Get Help',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Input field builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: iconColor),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: const Color.fromRGBO(0, 0, 0, 0.2),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF91AF82)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF91AF82), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Handles offline pest search using JSON file
  void handlePestSearch(String crop, String issue) async {
    try {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/data/pest_data.json');
      final List<dynamic> pestData = jsonDecode(jsonString);

      final match = pestData.firstWhere(
        (entry) =>
            entry['crop'].toString().toLowerCase() == crop.toLowerCase() &&
            issue
                .toLowerCase()
                .contains(entry['symptoms'].toString().toLowerCase()),
        orElse: () => null,
      );

      if (!mounted) return;

      if (match != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PestResultScreen(
              pestName: match['pest'],
              symptoms: match['symptoms'],
              solution: match['solution'],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No matching pest found.")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading pest data: $e")),
      );
    }
  }
}
