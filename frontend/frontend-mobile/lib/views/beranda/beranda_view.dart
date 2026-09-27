import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../data/materi_data.dart';
import '../../models/materi_model.dart';
import '../../widgets/custom_footer.dart';
import '../../pretest/pretest_page.dart';
import '../../posttest/posttest_page.dart';
import '../materi/buka_materi_view.dart';

/// Halaman Beranda / Dashboard utama setelah pengguna login.
///
/// Struktur:
/// - Header profil pengguna (fixed, maroon)
/// - Card ringkasan statistik (jumlah materi & quiz)
/// - Grid materi yang scrollable
/// - [CustomFooter] fixed di bawah
class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  @override
  State<BerandaView> createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView> {
  int _footerIndex = 0;

  // ── Dummy data profil pengguna (ganti dengan data dari API/auth) ─────────
  static const _namaUser = 'Seto Aji Son Horeg';
  static const _kelasUser = 'Kelas 10 TKJ - SMKN 2 Jember';
  static const _totalMateri = 48;
  static const _totalQuiz = 120;

  void _onFooterTap(int idx) {
    setState(() => _footerIndex = idx);
    // TODO: Tambahkan navigasi ke halaman Peringkat / Profil
    if (idx == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Halaman Peringkat (coming soon)')));
    } else if (idx == 2) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Halaman Profil (coming soon)')));
    }
  }

  /// Tampilkan modal pilihan aksi saat kartu materi di-tap.
  /// Navigasi dilakukan dari parent context agar tidak crash setelah pop.
  void _showMateriActionSheet(BuildContext ctx, MateriModel materi) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (_) => _MateriActionSheet(
        materi: materi,
        onPreTest: () {
          Navigator.of(ctx).push(
            MaterialPageRoute(builder: (_) => const PretestPage()),
          );
        },
        onBukaMateri: () {
          Navigator.of(ctx).push(
            MaterialPageRoute(builder: (_) => BukaMateriView(materi: materi)),
          );
        },
        onPostTest: () {
          Navigator.of(ctx).push(
            MaterialPageRoute(builder: (_) => const PosttestPage()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      // ── Footer fixed di bawah ────────────────────────────────────────────
      bottomNavigationBar: CustomFooter(
        currentIndex: _footerIndex,
        onTap: _onFooterTap,
      ),
      body: SafeArea(
        bottom: false, // footer menangani safe area bawah sendiri
        child: Column(
          children: [
            // ── Header Profil — hp dihitung sendiri di dalam widget ─────────
            _ProfileHeader(nama: _namaUser, kelas: _kelasUser),

            // ── Konten Scrollable ─────────────────────────────────────────
            Expanded(
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  // hp dihitung dari lebar AKTUAL widget (bukan MediaQuery parent)
                  // agar selalu fresh saat navigasi masuk/keluar
                  final double hp =
                      (constraints.maxWidth * 0.075).clamp(22.0, 40.0);
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(hp, 0, hp, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card statistik
                          _StatsCard(
                            totalMateri: _totalMateri,
                            totalQuiz: _totalQuiz,
                          ),
                          const SizedBox(height: 24),

                          // Label section materi
                          Text(
                            'Materi Tersedia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Grid materi — responsive 2 kolom
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dummyMateriList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: 0.85,
                            ),
                            itemBuilder: (gridCtx, i) {
                              final materi = dummyMateriList[i];
                              return _MateriCard(
                                materi: materi,
                                onTap: () =>
                                    _showMateriActionSheet(gridCtx, materi),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Header Profil
// ────────────────────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final String nama;
  final String kelas;

  // Tidak menerima hp dari luar — dihitung sendiri agar selalu fresh
  const _ProfileHeader({required this.nama, required this.kelas});

  @override
  Widget build(BuildContext context) {
    // Hitung hp di sini agar selalu pakai context widget ini sendiri
    final double hp =
        (MediaQuery.of(context).size.width * 0.075).clamp(22.0, 40.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hp, 18, hp, 36),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Salam singkat
          Text(
            'Halo, ${nama.split(' ').first} 👋',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // Baris avatar + nama + kelas
          Row(
            children: [
              // Avatar inisial
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A7C59),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    nama.isNotEmpty ? nama[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Nama & kelas
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
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Card Statistik (Materi & Quiz)
// ────────────────────────────────────────────────────────────────────────────
class _StatsCard extends StatelessWidget {
  final int totalMateri;
  final int totalQuiz;

  const _StatsCard({required this.totalMateri, required this.totalQuiz});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              _StatItem(value: '$totalMateri', label: 'Materi'),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Colors.grey.shade200,
                indent: 20,
                endIndent: 20,
              ),
              _StatItem(value: '$totalQuiz', label: 'Total Quiz'),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Card Materi
// ────────────────────────────────────────────────────────────────────────────
class _MateriCard extends StatelessWidget {
  final MateriModel materi;
  final VoidCallback onTap;

  const _MateriCard({required this.materi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header maroon berisi kode kelas
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Text(
                materi.kelas,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Body card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      materi.judul,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    const Divider(height: 1),
                    const SizedBox(height: 8),
                    Text(
                      'Guru Mata Pelajaran:',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      materi.guruMapel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Modal Bottom Sheet: Pilihan Aksi Materi
// ────────────────────────────────────────────────────────────────────────────
class _MateriActionSheet extends StatelessWidget {
  final MateriModel materi;

  /// Callback navigasi dilakukan dari parent agar context tidak invalid.
  final VoidCallback onPreTest;
  final VoidCallback onBukaMateri;
  final VoidCallback onPostTest;

  const _MateriActionSheet({
    required this.materi,
    required this.onPreTest,
    required this.onBukaMateri,
    required this.onPostTest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Judul materi
          Text(
            materi.judul,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            materi.kelas,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),

          // Aksi: Kerjakan Pre-Test
          _ActionTile(
            icon: Icons.quiz_outlined,
            label: 'Kerjakan Pre-Test',
            onTap: () {
              // Tutup modal dulu, lalu navigasi dari parent context
              Navigator.pop(context);
              onPreTest();
            },
          ),
          const Divider(height: 1),

          // Aksi: Buka Materi
          _ActionTile(
            icon: Icons.menu_book_rounded,
            label: 'Buka Materi',
            onTap: () {
              Navigator.pop(context);
              onBukaMateri();
            },
          ),
          const Divider(height: 1),

          // Aksi: Post-Test
          _ActionTile(
            icon: Icons.assignment_turned_in_outlined,
            label: 'Post-Test',
            onTap: () {
              Navigator.pop(context);
              onPostTest();
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
      onTap: onTap,
    );
  }
}
