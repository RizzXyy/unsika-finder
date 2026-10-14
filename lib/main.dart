import 'package:flutter/material.dart';
import 'core/app_colors.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const UnsikaFinderApp());

class UnsikaFinderApp extends StatelessWidget {
  const UnsikaFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsika Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.maroon),
      ),
      home: const SplashScreen(),
    );
  }
}