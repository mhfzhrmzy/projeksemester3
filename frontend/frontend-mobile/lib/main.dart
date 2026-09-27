import 'package:flutter/material.dart';
import 'common/theme/app_colors.dart';
import 'login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dasar Python',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'PlusJakartaSans',
      ),
      // Entry point langsung ke halaman Login
      home: const LoginPage(),
    );
  }
}
