import 'package:tflite_flutter/tflite_flutter.dart';

class CropPredictor {
  static final CropPredictor _instance = CropPredictor._internal();

  late Interpreter _interpreter;
  bool _isModelLoaded = false;

  CropPredictor._internal();

  factory CropPredictor() {
    return _instance;
  }

  Future<void> loadModel() async {
    if (!_isModelLoaded) {
      try {
        _interpreter = await Interpreter.fromAsset('assets/tflite/crop_model.tflite');
        _isModelLoaded = true;
        // ignore: avoid_print
        print("TFLite model loaded successfully.");
      } catch (e) {
        // ignore: avoid_print
        print("Error loading TFLite model: $e");
      }
    }
  }

  Future<String> predictCrop({
    required double n,
    required double p,
    required double k,
    required double temperature,
    required double humidity,
    required double ph,
    required double rainfall,
  }) async {
    if (!_isModelLoaded) {
      await loadModel();
    }

    try {
      // Prepare input
      var input = [
        [n, p, k, temperature, humidity, ph, rainfall]
      ];

      // ignore: avoid_print
      print("Input to model: $input");

      // Prepare output buffer (1 x 22)
      var output = List.filled(1 * 22, 0.0).reshape([1, 22]);

      // Run inference
      _interpreter.run(input, output);

      // ignore: avoid_print
      print("Model output: ${output[0]}");

      // Find index of max confidence
      double maxValue = output[0].reduce((double a, double b) => a > b ? a : b);

      int predictedIndex = output[0].indexOf(maxValue);


      // ignore: avoid_print
      print("Predicted index: $predictedIndex");
      // ignore: avoid_print
      print("Predicted crop: ${_labels[predictedIndex]}");

      return _labels[predictedIndex];
    } catch (e) {
      // ignore: avoid_print
      print("Prediction error: $e");
      return "Prediction failed. Please try again";
    }
  }

  final List<String> _labels = [
    'apple', 'banana', 'blackgram', 'chickpea', 'coconut', 'coffee', 'cotton',
    'grapes', 'jute', 'kidneybeans', 'lentil', 'maize', 'mango', 'mothbeans',
    'mungbean', 'muskmelon', 'orange', 'papaya', 'pigeonpeas', 'pomegranate',
    'rice', 'watermelon'
  ];
}
