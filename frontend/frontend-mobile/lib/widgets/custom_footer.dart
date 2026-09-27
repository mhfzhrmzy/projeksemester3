import 'package:flutter/material.dart';
import '../common/theme/app_colors.dart';

/// Bottom Navigation Bar reusable yang selalu fixed di bagian bawah layar.
///
/// Gunakan di dalam [Scaffold.bottomNavigationBar] pada setiap halaman
/// yang membutuhkan footer ini.
///
/// Contoh penggunaan:
/// ```dart
/// Scaffold(
///   bottomNavigationBar: CustomFooter(currentIndex: 0),
///   body: ...,
/// )
/// ```
class CustomFooter extends StatelessWidget {
  /// Index tab yang sedang aktif:
  /// 0 = Home, 1 = Peringkat (Trophy), 2 = Profil
  final int currentIndex;

  /// Callback saat item di-tap. Jika null, navigasi dihandle secara internal.
  final ValueChanged<int>? onTap;

  const CustomFooter({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Padding(
            // Padding kiri-kanan agar ikon tidak terlalu mepet tepi layar
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FooterItem(
                  icon: Icons.home_outlined,
                  iconActive: Icons.home_rounded,
                  label: 'Home',
                  isActive: currentIndex == 0,
                  onTap: () => (onTap ?? (_) {})(0),
                ),
                _FooterItem(
                  icon: Icons.emoji_events_outlined,
                  iconActive: Icons.emoji_events_rounded,
                  label: 'Peringkat',
                  isActive: currentIndex == 1,
                  onTap: () => (onTap ?? (_) {})(1),
                ),
                _FooterItem(
                  icon: Icons.person_outline_rounded,
                  iconActive: Icons.person_rounded,
                  label: 'Profil',
                  isActive: currentIndex == 2,
                  onTap: () => (onTap ?? (_) {})(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Item tunggal pada CustomFooter.
class _FooterItem extends StatelessWidget {
  final IconData icon;
  final IconData iconActive;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FooterItem({
    required this.icon,
    required this.iconActive,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : Colors.grey.shade500;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? iconActive : icon,
              color: color,
              size: 26,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
