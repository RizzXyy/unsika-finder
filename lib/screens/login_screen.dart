import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/auth_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/brand_header.dart';
import '../widgets/primary_button.dart';
import 'main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  bool _remember = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _goToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  Future<void> _loginEmail() async {
    setState(() { _loading = true; _error = null; });
    final err = await AuthService.loginWithEmail(_emailC.text, _passC.text);
    if (!mounted) return;
    setState(() { _loading = false; _error = err; });
    if (err == null) _goToMain();
  }

  Future<void> _loginGoogle() async {
    setState(() { _loading = true; _error = null; });
    final err = await AuthService.loginWithGoogle();
    if (!mounted) return;
    setState(() { _loading = false; _error = err; });
    if (err == null) _goToMain();
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
              const SizedBox(height: 50),
              const BrandHeader(),
              const SizedBox(height: 40),
              const Text('Selamat Datang!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.maroon)),
              const SizedBox(height: 4),
              const Text('Silakan login untuk melanjutkan ke akun Anda',
                  style: TextStyle(fontSize: 13, color: AppColors.grey)),
              const SizedBox(height: 24),
              AppTextField(
                label: 'Email',
                hint: 'Contoh@student.unsika.ac.id',
                keyboardType: TextInputType.emailAddress,
                controller: _emailC,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Password',
                hint: 'Masukkan Password',
                isPassword: true,
                controller: _passC,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _remember,
                      onChanged: (v) => setState(() => _remember = v ?? false),
                      activeColor: AppColors.maroon,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Remember me',
                      style: TextStyle(fontSize: 13, color: AppColors.grey)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueLink)),
                  ),
                ],
              ),
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
                      Icon(Icons.error_outline, color: Colors.red.shade600, size: 18),
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
                  ? const Center(child: CircularProgressIndicator(color: AppColors.maroon))
                  : PrimaryButton(text: 'Log In', onPressed: _loginEmail),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Or',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _loading ? null : _loginGoogle,
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
                      Text('Continue with Google',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: const Text(
                  '⚠️ Hanya akun @student.unsika.ac.id yang dapat login',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Belum punya akun? ',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()),
                      ),
                      child: const Text('Register',
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