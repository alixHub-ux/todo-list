// lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/authentification/login.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: Center(
        child: Image.asset(
          'assets/logo/LystLogo.png',
          width: 120,
        ),
      ),
    );
  }
}
