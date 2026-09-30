import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/theme/app_colors.dart';
import '../../login/login_page.dart';
import '../../widgets/custom_footer.dart';
import '../leaderboard/leaderboard_view.dart';
import '../sertifikat/sertifikat_view.dart';

/// Halaman Profil pengguna.
///
/// Struktur (mengikuti desain Figma "Profile"):
/// - Header maroon melengkung berisi avatar inisial, nama, dan kelas/sekolah
/// - Menu utama: "Pengaturan akun siswa" (solid) & "Sertifikat & Portofolio" (outline)
/// - Tombol "Keluar Akun" (soft pink) di atas footer
/// - [CustomFooter] fixed di bawah dengan tab Profil aktif (index 2)
///
/// Navigasi:
/// - Tab Home  -> kembali ke Beranda (root route)
/// - Tab Peringkat -> [LeaderboardView]
/// - Sertifikat & Portofolio -> [SertifikatView]
/// - Keluar Akun -> dialog konfirmasi, lalu kembali ke [LoginPage]
class ProfileView extends StatelessWidget {
  /// Nama lengkap pengguna. Default = dummy data yang sama dengan Beranda.
  final String nama;

  /// Kelas & sekolah pengguna.
  final String kelas;

  const ProfileView({
    super.key,
    this.nama = 'Seto Son Horeg',
    this.kelas = 'Kelas 10 TKJ - SMKN 2 Jember',
  });

  // ── Warna khusus halaman Profil (belum ada di AppColors) ─────────────────
  static const Color _avatarOlive = Color(0xFF76832F);
  static const Color _logoutBackground = Color(0xFFFFF0F1);
  static const Color _logoutBorder = Color(0xFFF3C4CB);

  // ── Navigasi footer ──────────────────────────────────────────────────────
  void _onFooterTap(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        // Beranda adalah root route setelah login, jadi cukup pop sampai root.
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LeaderboardView()),
        );
        break;
      case 2:
        // Sudah berada di halaman Profil.
        break;
    }
  }

  // ── Placeholder aksi menu ────────────────────────────────────────────────
  void _showComingSoon(BuildContext context, String namaHalaman) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$namaHalaman (coming soon)')),
      );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final bool? yakin = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Keluar Akun?',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Kamu akan keluar dari akun ini dan kembali ke halaman Login.',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text(
              'Keluar',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (yakin != true || !context.mounted) return;

    // TODO: hapus sesi/token login di sini saat backend sudah terhubung.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // ── Footer fixed di bawah (tab Profil aktif) ─────────────────────────
      bottomNavigationBar: CustomFooter(
        currentIndex: 2,
        onTap: (idx) => _onFooterTap(context, idx),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          // top: false agar header maroon full-bleed ke belakang status bar,
          // sama seperti Beranda / Pre-Test / Post-Test.
          top: false,
          bottom: false, // footer menangani safe area bawah sendiri
          child: Column(
            children: [
              _ProfileHeader(
                nama: nama,
                kelas: kelas,
                avatarColor: _avatarOlive,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (ctx, constraints) {
                    final double hp =
                        (constraints.maxWidth * 0.075).clamp(22.0, 40.0);
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(hp, 0, hp, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Spacer(flex: 3),

                                // ── Menu utama ───────────────────────────────
                                _ProfileMenuButton(
                                  label: 'Pengaturan akun siswa',
                                  filled: true,
                                  onTap: () => _showComingSoon(
                                      context, 'Halaman Pengaturan akun siswa'),
                                ),
                                const SizedBox(height: 14),
                                _ProfileMenuButton(
                                  label: 'Sertifikat & Portofolio',
                                  filled: false,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => const SertifikatView()),
                                  ),
                                ),

                                const Spacer(flex: 4),

                                // ── Keluar Akun ──────────────────────────────
                                _LogoutButton(
                                  backgroundColor: _logoutBackground,
                                  borderColor: _logoutBorder,
                                  onTap: () => _confirmLogout(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Header Profil (maroon melengkung, full bleed sampai atas status bar)
// ────────────────────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final String nama;
  final String kelas;
  final Color avatarColor;

  const _ProfileHeader({
    required this.nama,
    required this.kelas,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarHeight = mediaQuery.viewPadding.top;
    final double hp = (mediaQuery.size.width * 0.075).clamp(22.0, 40.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Ikon status bar putih agar kontras di atas maroon.
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Material(
        elevation: 6,
        shadowColor: AppColors.softShadow,
        color: AppColors.primary,
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        child: Stack(
          children: [
            // Aksen lengkung halus di latar header (mengikuti gelombang Figma)
            Positioned(
              top: -70,
              right: -50,
              child: _softCircle(220),
            ),
            Positioned(
              bottom: -90,
              left: -60,
              child: _softCircle(200),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: statusBarHeight + 34,
                bottom: 34,
                left: hp,
                right: hp,
              ),
              child: Row(
                children: [
                  // Avatar squircle olive dengan inisial
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: avatarColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        nama.isNotEmpty ? nama[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kelas,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _softCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.05),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Tombol menu (solid / outline)
// ────────────────────────────────────────────────────────────────────────────
class _ProfileMenuButton extends StatelessWidget {
  final String label;

  /// true  = solid maroon, teks putih
  /// false = outline maroon, background putih, teks maroon
  final bool filled;
  final VoidCallback onTap;

  const _ProfileMenuButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(12);

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Material(
        color: filled ? AppColors.primary : Colors.white,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: filled ? Colors.white : AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Tombol Keluar Akun (soft pink)
// ────────────────────────────────────────────────────────────────────────────
class _LogoutButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _LogoutButton({
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(12);

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Material(
          color: backgroundColor,
          borderRadius: radius,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(color: borderColor),
              ),
              child: const Text(
                'Keluar Akun',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}