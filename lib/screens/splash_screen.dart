import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/auth_service.dart';
import '../widgets/unsika_logo.dart';
import 'login_screen.dart';
import 'main_screen.dart';

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
      final target = AuthService.currentUser != null
          ? const MainScreen()
          : const LoginScreen();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => target));
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