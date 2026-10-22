import 'package:flutter/material.dart';
import 'package:pretest_posttest_app/inti/konstanta/warna_aplikasi.dart';
import 'package:pretest_posttest_app/fitur/autentikasi/widgets/header_autentikasi.dart';
import 'package:pretest_posttest_app/fitur/autentikasi/widgets/ikon_avatar_autentikasi.dart';
import 'package:pretest_posttest_app/fitur/autentikasi/widgets/kolom_teks_autentikasi.dart';

/// Halaman Registrasi — pendaftaran akun baru.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _kontrolerNama = TextEditingController();
  final _kontrolerKelas = TextEditingController();
  final _kontrolerPassword = TextEditingController();
  final _kontrolerKonfirmasi = TextEditingController();

  /// Warna border kartu autentikasi.
  static final Color _warnaKartuBorder =
      WarnaAplikasi.utama.withValues(alpha: 0.18);

  @override
  void dispose() {
    _kontrolerNama.dispose();
    _kontrolerKelas.dispose();
    _kontrolerPassword.dispose();
    _kontrolerKonfirmasi.dispose();
    super.dispose();
  }

  void _daftar() {
    // TODO: Hubungkan ke API registrasi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaAplikasi.latarBelakangAutentikasi,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderAutentikasi(judul: 'Registrasi'),
            const SizedBox(height: 22),
            const IkonAvatarAutentikasi(),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _warnaKartuBorder),
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
                    KolomTeksAutentikasi(
                      label: 'Nama Lengkap',
                      petunjuk: 'Masukkan nama lengkap',
                      kontroler: _kontrolerNama,
                    ),
                    const SizedBox(height: 14),
                    KolomTeksAutentikasi(
                      label: 'Kelas',
                      petunjuk: 'Contoh: Kelas 10 TKJ',
                      kontroler: _kontrolerKelas,
                    ),
                    const SizedBox(height: 14),
                    KolomTeksAutentikasi(
                      label: 'Password',
                      petunjuk: 'Buat password',
                      rahasia: true,
                      kontroler: _kontrolerPassword,
                    ),
                    const SizedBox(height: 14),
                    KolomTeksAutentikasi(
                      label: 'Konfirmasi Password',
                      petunjuk: 'Ulangi password',
                      rahasia: true,
                      kontroler: _kontrolerKonfirmasi,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _daftar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: WarnaAplikasi.utama,
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
