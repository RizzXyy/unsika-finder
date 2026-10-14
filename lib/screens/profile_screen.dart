import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onOpenHistory;
  const ProfileScreen({super.key, this.onOpenHistory});

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur ini segera hadir')),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar',
                style: TextStyle(color: AppColors.maroon)),
          ),
        ],
      ),
    );
    if (yes == true && context.mounted) {
      await AuthService.logout();
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final menus = <(IconData, String, VoidCallback)>[
      (Icons.description_outlined, 'Laporan Saya', onOpenHistory ?? () {}),
      (Icons.history, 'Riwayat Laporan', onOpenHistory ?? () {}),
      (Icons.notifications_none_rounded, 'Notifikasi', () => _soon(context)),
      (Icons.settings_outlined, 'Pengaturan Akun', () => _soon(context)),
      (Icons.menu_book_outlined, 'Bantuan & Panduan', () => _soon(context)),
      (Icons.info_outline, 'Tentang Aplikasi', () => _soon(context)),
    ];

    final user = AuthService.currentUser;
    final displayName = user?.displayName ??
        (user?.email != null ? user!.email!.split('@').first : 'Mahasiswa Unsika');
    final emailOrNpm = user?.email ?? 'Tidak ada email';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          children: [
            const Text('Profil',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.maroonDark,
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  child: user?.photoURL == null
                      ? const Icon(Icons.person, size: 56, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F2A33))),
                      const SizedBox(height: 4),
                      Text(emailOrNpm,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            ...menus.map((m) => InkWell(
              onTap: m.$3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Icon(m.$1, size: 24, color: Colors.black87),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(m.$2,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                    const Icon(Icons.chevron_right,
                        size: 22, color: Colors.black87),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 14),
            SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () => _confirmLogout(context),
                icon: const Icon(Icons.logout, size: 20),
                label: const Text('Keluar',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.maroonDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}