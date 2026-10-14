import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/brand_header.dart';
import '../../widgets/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const BrandHeader(),
              const SizedBox(height: 24),
              const Text('Daftar Akun',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.maroon)),
              const SizedBox(height: 4),
              const Text(
                  'Buat akun baru untuk melaporkan barang hilang atau temuan',
                  style: TextStyle(fontSize: 13, color: AppColors.grey)),
              const SizedBox(height: 20),
              const AppTextField(
                  label: 'Nama Lengkap', hint: 'Masukkan nama lengkap'),
              const SizedBox(height: 14),
              const AppTextField(
                  label: 'NPM',
                  hint: 'Masukkan NPM',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 14),
              const AppTextField(
                  label: 'Email',
                  hint: 'Contoh@student.unsika.ac.id',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              const AppTextField(
                  label: 'Phone Number',
                  hint: '+62 81234567890',
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 14),
              const AppTextField(
                  label: 'Password',
                  hint: 'Minimal 8 karakter',
                  isPassword: true),
              const SizedBox(height: 24),
              PrimaryButton(text: 'Daftar', onPressed: () {}),
              const SizedBox(height: 14),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Sudah punya akun? ',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueLink)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}