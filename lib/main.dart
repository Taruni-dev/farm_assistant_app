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
        '/forgot_password': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return ForgotPasswordScreen(username: args);
        },
        '/dashboard': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return DashboardScreen(username: args);
        },
        '/crop_input': (context) => const CropInputScreen(),
        '/crop_result': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return CropResultScreen(cropName: args);
        },
        '/pest_help': (context) => const PestHelpScreen(),
        '/pest_result': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, String>;
          return PestResultScreen(
            pestName: args['pestName'] ?? '',
            symptoms: args['symptoms'] ?? '',
            solution: args['solution'] ?? '',
          );
        },
      },
    );
  }
}
