import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../beranda/beranda_view.dart';
import 'register_view.dart';
import 'pretest_view.dart';
import 'posttest_view.dart';

/// Halaman pertama yang muncul saat aplikasi dijalankan.
/// Menampilkan logo toga, judul "Dasar Python", dan 4 tombol aksi utama.
class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Logo toga ──────────────────────────────────────────────
                Icon(
                  Icons.school_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 18),

                // ── Judul aplikasi ─────────────────────────────────────────
                Text(
                  'Dasar Python',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 48),

                // ── Tombol Login ───────────────────────────────────────────
                _AuthButton(
                  label: 'Login',
                  onTap: () {
                    // Login langsung menuju Beranda (bypass form sementara)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const BerandaView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // ── Tombol Registrasi ──────────────────────────────────────
                _AuthButton(
                  label: 'Registrasi',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RegisterView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // ── Tombol Mulai Pre-Test ──────────────────────────────────
                _AuthButton(
                  label: 'Mulai Pre-Test',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PretestView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // ── Tombol Mulai Post-Test ─────────────────────────────────
                _AuthButton(
                  label: 'Mulai Post-Test',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PosttestView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Tombol reusable khusus halaman Auth.
class _AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AuthButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
        elevation: 4,
        shadowColor: AppColors.softShadow,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
