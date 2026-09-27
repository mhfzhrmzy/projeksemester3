import 'package:flutter/material.dart';
import '../../pretest/pretest_page.dart';

/// Wrapper view untuk Pre-Test — memanggil engine PreTestPage yang sudah ada.
/// Ditempatkan di views/auth/ agar bisa dipanggil dari AuthView.
class PretestView extends StatelessWidget {
  const PretestView({super.key});

  @override
  Widget build(BuildContext context) => const PretestPage();
}
