import 'package:flutter/material.dart';
import '../common/theme/auth_colors.dart';
import '../common/widgets/auth_header.dart';
import '../common/widgets/auth_avatar_icon.dart';
import '../common/widgets/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nisnController = TextEditingController();
  final _namaController = TextEditingController();
  final _kelasController = TextEditingController();
  final _jurusanController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  @override
  void dispose() {
    _nisnController.dispose();
    _namaController.dispose();
    _kelasController.dispose();
    _jurusanController.dispose();
    _passwordController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  void _register() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi ditekan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Padding horizontal selaras dengan TestPage (Pre/Post-Test)
    final double hp = (MediaQuery.of(context).size.width * 0.075).clamp(22.0, 40.0);

    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(title: 'Registrasi'),
            const SizedBox(height: 22),
            const AuthAvatarIcon(),
            const SizedBox(height: 22),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kCardBorder.withValues(alpha: 0.4)),
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
                      label: 'NISN',
                      hint: 'Masukkan NISN',
                      controller: _nisnController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Nama Lengkap',
                      hint: 'Masukkan Nama Lengkap',
                      controller: _namaController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Kelas',
                      hint: 'Masukkan Kelas',
                      controller: _kelasController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Jurusan',
                      hint: 'Masukkan Jurusan',
                      controller: _jurusanController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Password',
                      hint: 'Masukkan Password',
                      obscure: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 14),
                    AuthTextField(
                      label: 'Konfirmasi Password',
                      hint: 'Masukkan Konfirmasi Password',
                      obscure: true,
                      controller: _konfirmasiController,
                    ),
                    const SizedBox(height: 14),
                    RichText(
                      text: TextSpan(
                        text: 'Apakah sudah punya akun? Jika sudah ',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kMaroon,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kMaroon,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Registrasi',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
