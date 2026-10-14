import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/unsika_logo.dart';
import '../../core/app_colors.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UnsikaLogo(size: 60),
        SizedBox(width: 14),
        Text(
          'Unsika\nFinder',
          style: TextStyle(
            fontSize: 26,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: AppColors.maroon,
          ),
        ),
      ],
    );
  }
}