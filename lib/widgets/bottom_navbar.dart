import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Navbar bawah (Home, Laporan, Riwayat, Profil)
class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _icons = [
    Icons.home_outlined,
    Icons.assignment_outlined,
    Icons.history,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.maroonDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icons.length, (i) {
          final selected = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              width: 60,
              height: 44,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF8B2A47) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_icons[i], color: Colors.white, size: 30),
            ),
          );
        }),
      ),
    );
  }
}