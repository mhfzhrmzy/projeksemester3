import 'package:flutter/material.dart';
import '../../posttest/posttest_page.dart';

/// Wrapper view untuk Post-Test — memanggil engine PostTestPage yang sudah ada.
/// Ditempatkan di views/auth/ agar bisa dipanggil dari AuthView.
class PosttestView extends StatelessWidget {
  const PosttestView({super.key});

  @override
  Widget build(BuildContext context) => const PosttestPage();
}
