import 'package:flutter/material.dart';

/// Logo Unsika. File ada di assets/images/logo.png
class UnsikaLogo extends StatelessWidget {
  final double size;
  const UnsikaLogo({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      errorBuilder: (ctx, err, st) =>
          Icon(Icons.school, size: size, color: const Color(0xFFFFD400)),
    );
  }
}