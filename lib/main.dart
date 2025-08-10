import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/crop_input_screen.dart';
import 'screens/crop_result_screen.dart';
import 'screens/pest_help_screen.dart';
import 'screens/pest_result_screen.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Assistant',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login_signup': (context) => const LoginSignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/crop_input': (context) => const CropInputScreen(),
        '/crop_result': (context) => const CropResultScreen(cropName: 'Crop'),
        '/pest_help': (context) => const PestHelpScreen(),
        '/pest_result': (context) => const PestResultScreen(
              pestName: '',
              symptoms: '',
              solution: '',
            ),
      },
    );
  }
}
