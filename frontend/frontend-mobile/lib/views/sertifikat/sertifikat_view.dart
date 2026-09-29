import 'dart:ui';
import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../widgets/custom_footer.dart';
import '../beranda/beranda_view.dart';
import '../leaderboard/leaderboard_view.dart';

/// Item model untuk daftar sertifikat
class SertifikatItem {
  final String label;
  final String judul;
  final String tanggalTerbit;
  final String? fileUrl;

  const SertifikatItem({
    required this.label,
    required this.judul,
    required this.tanggalTerbit,
    this.fileUrl,
  });
}

/// Halaman Sertifikat & Portofolio
/// Sesuai desain acuan (Foto 3):
/// - Tombol pill back `(< Back)`
/// - Judul utama "Sertifikat & Portofolio"
/// - Section "Upload Sertifikat Baru" dengan dropzone dashed border & icon cloud upload
/// - Section "Daftar sertifikat" dengan card outline maroon & tombol "Unduh Sertifikat"
/// - Bottom Navigation Bar
class SertifikatView extends StatefulWidget {
  const SertifikatView({super.key});

  @override
  State<SertifikatView> createState() => _SertifikatViewState();
}

class _SertifikatViewState extends State<SertifikatView> {
  // Dummy daftar sertifikat
  final List<SertifikatItem> _daftarSertifikat = [
    const SertifikatItem(
      label: 'Sertifikat',
      judul: 'Dasar Phyton',
      tanggalTerbit: 'Diterbitkan: 12 maret 2026',
    ),
  ];

  void _onFooterTap(int idx) {
    if (idx == 2) return; // sudah di Sertifikat

    if (idx == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BerandaView()),
        (route) => false,
      );
    } else if (idx == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LeaderboardView()),
      );
    }
  }

  void _handleUploadFile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Upload Sertifikat Baru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih file sertifikat dari perangkat Anda (PDF, PNG, JPG maks 5MB).',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File berhasil dipilih & diunggah!'),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text(
                'Pilih File dari Galeri/Dokumen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDownload(SertifikatItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mengunduh sertifikat ${item.judul}...'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomFooter(
        currentIndex: 2,
        onTap: _onFooterTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Tombol Back Pill ───────────────────────────────────────────
              InkWell(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const BerandaView()),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      width: 1.2,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ── Judul Halaman ─────────────────────────────────────────────
              const Text(
                'Sertifikat & Portofolio',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              // ── Section 1: Upload Sertifikat Baru ──────────────────────────
              Text(
                'Upload Sertifikat Baru',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),

              const SizedBox(height: 12),

              // Dashed Dropzone Card
              InkWell(
                onTap: _handleUploadFile,
                borderRadius: BorderRadius.circular(14),
                child: CustomPaint(
                  painter: _DashedBorderPainter(
                    color: AppColors.primary.withValues(alpha: 0.7),
                    strokeWidth: 1.5,
                    gap: 5,
                    dashLength: 6,
                    radius: 14,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 44,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Upload File Disini',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '(format PDF, PNG, JPG maks 5MB).',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── Section 2: Daftar sertifikat ──────────────────────────────
              Text(
                'Daftar sertifikat',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),

              const SizedBox(height: 12),

              // Card List Sertifikat
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _daftarSertifikat.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (ctx, idx) {
                  final item = _daftarSertifikat[idx];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.judul,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.tanggalTerbit,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () => _handleDownload(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Unduh Sertifikat',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CustomPainter untuk menggambar garis putus-putus (Dashed Border) melengkung
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashLength = 6,
    this.gap = 4,
    this.radius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final PathMetrics pathMetrics = path.computeMetrics();

    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double length = (distance + dashLength < pathMetric.length)
            ? dashLength
            : pathMetric.length - distance;
        final Path extractPath = pathMetric.extractPath(distance, distance + length);
        canvas.drawPath(extractPath, paint);
        distance += length + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gap != gap ||
        oldDelegate.radius != radius;
  }
}
