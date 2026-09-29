import 'package:flutter/material.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/test_header.dart';
import '../../models/materi_model.dart';
import '../../widgets/custom_footer.dart';
import '../profile/profile_view.dart';

/// Halaman Buka Materi.
///
/// Fitur & Desain:
/// - Header maroon menggunakan [TestHeader] yang sama persis dengan Pre-Test dan Post-Test:
///   full-bleed hingga status bar (ikon jam, baterai, wifi berwarna putih), posisi judul,
///   radius lengkungan 36px, dan bayangan yang selaras.
/// - Tombol Back (kembali ke beranda) FIXED di bawah header.
/// - Yang di-scroll HANYA dari "Deskripsi singkat" sampai kotak materi PDF.
/// - Kotak isi materi berukuran FIX (proporsional A4: 210 x 297 mm, tanpa scroll di dalam kotaknya).
/// - Kotak deskripsi otomatis menyesuaikan tinggi teks (auto-height) tanpa terpotong.
/// - Tombol navigasi halaman (< Back | Halaman X/Y | Next >) dan tombol Selesai FIXED di bawah.
/// - CustomFooter fixed di bawah.
/// - Responsif penuh di mobile & tablet (portrait maupun landscape).
class BukaMateriView extends StatefulWidget {
  final MateriModel materi;

  const BukaMateriView({super.key, required this.materi});

  @override
  State<BukaMateriView> createState() => _BukaMateriViewState();
}

class _BukaMateriViewState extends State<BukaMateriView> {
  int _currentPage = 0;
  int _footerIndex = 0;

  int get _totalPages => widget.materi.totalHalaman;
  bool get _isFirst => _currentPage == 0;
  bool get _isLast => _currentPage == _totalPages - 1;

  void _prevPage() {
    if (_isFirst) return;
    setState(() => _currentPage--);
  }

  void _nextPage() {
    if (_isLast) return;
    setState(() => _currentPage++);
  }

  void _selesai() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.materi.judul} selesai dipelajari! 🎉'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Future<void> _onFooterTap(int idx) async {
  if (idx == 0) {
    Navigator.of(context).pop();
  } else if (idx == 1) {
    setState(() => _footerIndex = idx);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Halaman Peringkat (coming soon)')),
    );
  } else if (idx == 2) {
    setState(() => _footerIndex = idx);
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProfileView()),
    );
    if (!mounted) return;
    setState(() => _footerIndex = 0);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomFooter(
        currentIndex: _footerIndex,
        onTap: _onFooterTap,
      ),
      // SafeArea top: false agar TestHeader full-bleed ke atas layar di belakang status bar
      body: SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Padding horizontal proporsional (7.5% lebar layar, clamp 20–44)
            final double hp =
                (constraints.maxWidth * 0.075).clamp(20.0, 44.0);

            final double containerWidth = constraints.maxWidth - (hp * 2);

            // Tinggi FIX kotak materi proporsional rasio kertas A4 (210 x 297 mm, 1 : 1.4142)
            final double a4Height =
                (containerWidth * (297.0 / 210.0)).clamp(360.0, 560.0);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── 1. Header Materi (Sama persis dengan Pre-Test & Post-Test) ──
                TestHeader(title: widget.materi.judul),

                // ── 2. Tombol Back ke Beranda (FIXED, tidak ikut ter-scroll) ─
                Padding(
                  padding: EdgeInsets.fromLTRB(hp, 14, hp, 6),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _BackButton(
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),

                // ── 3. Konten Scrollable (HANYA Deskripsi Singkat & Kolom Materi) ──
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(hp, 6, hp, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label Deskripsi singkat
                        const _DeskripsiLabel(),
                        const SizedBox(height: 6),

                        // Container deskripsi (auto-height, responsif terhadap panjang teks)
                        _DeskripsiBox(deskripsi: widget.materi.deskripsi),
                        const SizedBox(height: 14),

                        // Kotak Materi PDF (FIXED ukuran A4, TANPA scroll di dalamnya)
                        // Permukaan putih bersih siap untuk render file PDF nantinya
                        _PdfContainerBox(height: a4Height),
                      ],
                    ),
                  ),
                ),

                // ── 4. Kontrol Bawah (FIXED di bawah sebelum Footer) ─────────
                Padding(
                  padding: EdgeInsets.fromLTRB(hp, 8, hp, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Navigasi halaman: < Back | Halaman X/Y | Next >
                      _NavControlsRow(
                        currentPage: _currentPage,
                        totalPages: _totalPages,
                        isFirst: _isFirst,
                        isLast: _isLast,
                        onPrev: _prevPage,
                        onNext: _nextPage,
                      ),
                      const SizedBox(height: 10),

                      // Tombol Selesai maroon
                      _SelesaiButton(onPressed: _selesai),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tombol Back kecil (Pill Shape)
// ─────────────────────────────────────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              Icons.arrow_circle_left_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            SizedBox(width: 6),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Label "Deskripsi singkat"
// ─────────────────────────────────────────────────────────────────────────────
class _DeskripsiLabel extends StatelessWidget {
  const _DeskripsiLabel();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Deskripsi singkat',
      style: TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Container Deskripsi Singkat (Auto-Height, Responsive)
// ─────────────────────────────────────────────────────────────────────────────
class _DeskripsiBox extends StatelessWidget {
  final String deskripsi;

  const _DeskripsiBox({required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        deskripsi,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade800,
          height: 1.45,
        ),
        softWrap: true,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Container Materi PDF (FIX Ukuran A4, TANPA Scroll di Dalamnya)
// ─────────────────────────────────────────────────────────────────────────────
class _PdfContainerBox extends StatelessWidget {
  final double height;

  const _PdfContainerBox({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bar Navigasi Halaman (< Back | Halaman X/Y | Next >)
// ─────────────────────────────────────────────────────────────────────────────
class _NavControlsRow extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _NavControlsRow({
    required this.currentPage,
    required this.totalPages,
    required this.isFirst,
    required this.isLast,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tombol < Back
        _NavButton(
          label: 'Back',
          isBack: true,
          isDisabled: isFirst,
          onTap: isFirst ? null : onPrev,
        ),

        // Indikator Halaman maroon
        Text(
          'Halaman ${currentPage + 1}/$totalPages',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Tombol Next >
        _NavButton(
          label: 'Next',
          isBack: false,
          isDisabled: isLast,
          onTap: isLast ? null : onNext,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tombol Navigasi Halaman Pill (< Back / Next >)
// ─────────────────────────────────────────────────────────────────────────────
class _NavButton extends StatelessWidget {
  final String label;
  final bool isBack;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _NavButton({
    required this.label,
    required this.isBack,
    required this.isDisabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color activeColor = AppColors.primary;
    final Color disabledColor = Colors.grey.shade400;

    final Color effectiveColor = isDisabled ? disabledColor : activeColor;
    final Color effectiveBorder = isDisabled
        ? Colors.grey.shade300
        : activeColor.withValues(alpha: 0.4);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: effectiveBorder, width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isBack) ...[
              Icon(
                Icons.arrow_circle_left_outlined,
                size: 16,
                color: effectiveColor,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: effectiveColor,
              ),
            ),
            if (!isBack) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: 16,
                color: effectiveColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tombol Selesai (Maroon)
// ─────────────────────────────────────────────────────────────────────────────
class _SelesaiButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SelesaiButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Selesai',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
