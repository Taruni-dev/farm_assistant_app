import 'package:flutter/material.dart';
import 'crop_result_screen.dart';
import '../services/crop_predictor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CropInputScreen extends StatefulWidget {
  const CropInputScreen({super.key});

  @override
  State<CropInputScreen> createState() => _CropInputScreenState();
}

class _CropInputScreenState extends State<CropInputScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController rainfallController = TextEditingController();

  bool _isLoading = false;

  void _predictAndNavigate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String crop = await CropPredictor().predictCrop(
        n: double.parse(nController.text),
        p: double.parse(pController.text),
        k: double.parse(kController.text),
        temperature: double.parse(tempController.text),
        humidity: double.parse(humidityController.text),
        ph: double.parse(phController.text),
        rainfall: double.parse(rainfallController.text),
      );

      if (!mounted) return;

      if (crop != "Prediction failed. Please try again") {
        Fluttertoast.showToast(
          msg: "🌾 Crop predicted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CropResultScreen(cropName: crop),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Prediction failed. Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Prediction failed. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      debugPrint("Prediction error: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Green.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      '🌿 Recommend a Crop',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInputField('Nitrogen (N)', nController),
                    _buildInputField('Phosphorus (P)', pController),
                    _buildInputField('Potassium (K)', kController),
                    _buildInputField('Temperature (°C)', tempController),
                    _buildInputField('Humidity (%)', humidityController),
                    _buildInputField('pH Level', phController),
                    _buildInputField('Rainfall (mm)', rainfallController),
                    const SizedBox(height: 25),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _predictAndNavigate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF90EE90),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            child: const Text('Recommend Crop'),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF91AF82)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF91AF82)),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
