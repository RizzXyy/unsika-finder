import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import '../../core/app_colors.dart';
import '../../widgets/unsika_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UnsikaLogo(size: 120),
            SizedBox(height: 12),
            Text(
              'Unsika Finder',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.maroon,
                shadows: [
                  Shadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}