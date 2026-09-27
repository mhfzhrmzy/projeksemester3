import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/theme/auth_colors.dart';
import '../../common/widgets/auth_header.dart';
import '../../common/widgets/auth_avatar_icon.dart';
import '../../common/widgets/auth_text_field.dart';

/// Halaman Registrasi — pendaftaran akun baru.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _namaController = TextEditingController();
  final _kelasController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _kelasController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _register() {
    // TODO: Hubungkan ke API registrasi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(title: 'Registrasi'),
            const SizedBox(height: 24),
            const AuthAvatarIcon(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: kCardBorder.withValues(alpha: 0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                      label: 'Nama Lengkap',
                      hint: 'Masukkan nama lengkap',
                      controller: _namaController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Kelas',
                      hint: 'Contoh: Kelas 10 TKJ',
                      controller: _kelasController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Password',
                      hint: 'Buat password',
                      obscure: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Konfirmasi Password',
                      hint: 'Ulangi password',
                      obscure: true,
                      controller: _confirmController,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
