import 'package:flutter/material.dart';
import 'package:pretest_posttest_app/inti/konstanta/warna_aplikasi.dart';

/// TextField bulat dengan label, digunakan di halaman Login & Register.
///
/// Warna border lembut saat normal, menjadi maroon saat fokus.
class KolomTeksAutentikasi extends StatelessWidget {
  final String label;
  final String petunjuk;
  final bool rahasia;
  final TextEditingController? kontroler;
  final TextInputType tipeKeyboard;

  const KolomTeksAutentikasi({
    super.key,
    required this.label,
    required this.petunjuk,
    this.rahasia = false,
    this.kontroler,
    this.tipeKeyboard = TextInputType.text,
  });

  /// Warna border kartu autentikasi — menggunakan border dari WarnaAplikasi
  /// dengan opacity rendah agar kontras lembut di atas putih.
  static final Color _warnaKartuBorder =
      WarnaAplikasi.utama.withValues(alpha: 0.18);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: kontroler,
          obscureText: rahasia,
          keyboardType: tipeKeyboard,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: petunjuk,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: _warnaKartuBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: WarnaAplikasi.utama,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
