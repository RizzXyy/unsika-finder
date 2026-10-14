import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/auth_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/brand_header.dart';
import '../widgets/primary_button.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameC = TextEditingController();
  final _npmC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _nameC.dispose();
    _npmC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _passC.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_nameC.text.trim().isEmpty || _npmC.text.trim().isEmpty) {
      setState(() => _error = 'Nama dan NPM wajib diisi');
      return;
    }
    setState(() { _loading = true; _error = null; });
    final err = await AuthService.registerWithEmail(_emailC.text, _passC.text);
    if (!mounted) return;
    setState(() { _loading = false; _error = err; });
    if (err == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  Future<void> _registerGoogle() async {
    setState(() { _loading = true; _error = null; });
    final err = await AuthService.loginWithGoogle();
    if (!mounted) return;
    setState(() { _loading = false; _error = err; });
    if (err == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

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
              const SizedBox(height: 8),
              // Info domain
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Text(
                  'ℹ️ Gunakan akun Google @student.unsika.ac.id kamu untuk daftar cepat, '
                  'atau isi form di bawah dengan email @student.unsika.ac.id',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 16),
              // Daftar cepat dengan Google
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _loading ? null : _registerGoogle,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('G',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4285F4))),
                      SizedBox(width: 10),
                      Text('Daftar dengan Google',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('atau isi form',
                        style: TextStyle(fontSize: 12, color: AppColors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 16),
              AppTextField(
                  label: 'Nama Lengkap',
                  hint: 'Masukkan nama lengkap',
                  controller: _nameC),
              const SizedBox(height: 14),
              AppTextField(
                  label: 'NPM',
                  hint: 'Masukkan NPM',
                  keyboardType: TextInputType.number,
                  controller: _npmC),
              const SizedBox(height: 14),
              AppTextField(
                  label: 'Email',
                  hint: 'Contoh@student.unsika.ac.id',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailC),
              const SizedBox(height: 14),
              AppTextField(
                  label: 'Phone Number',
                  hint: '+62 81234567890',
                  keyboardType: TextInputType.phone,
                  controller: _phoneC),
              const SizedBox(height: 14),
              AppTextField(
                  label: 'Password',
                  hint: 'Minimal 8 karakter',
                  isPassword: true,
                  controller: _passC),
              // Error message
              if (_error != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red.shade600, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(_error!,
                            style: TextStyle(
                                fontSize: 13, color: Colors.red.shade700)),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.maroon))
                  : PrimaryButton(text: 'Daftar', onPressed: _register),
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