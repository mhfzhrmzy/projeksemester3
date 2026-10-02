import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/theme/app_colors.dart';
import '../../widgets/custom_footer.dart';
import '../beranda/beranda_view.dart';
import '../leaderboard/leaderboard_view.dart';
import '../profile/profile_view.dart';
import 'upload_sertifikat_view.dart';

/// Item model untuk daftar sertifikat
class SertifikatItem {
  final String label;
  final String judul;
  final String tanggalTerbit;
  final DateTime tanggal;
  final String? fileUrl;

  const SertifikatItem({
    required this.label,
    required this.judul,
    required this.tanggalTerbit,
    required this.tanggal,
    this.fileUrl,
  });
}

class SertifikatView extends StatefulWidget {
  /// Daftar sertifikat awal – bisa dioper dari UploadSertifikatView
  /// setelah operasi CRUD agar data tetap sinkron.
  final List<SertifikatItem>? initialDaftar;

  const SertifikatView({super.key, this.initialDaftar});

  @override
  State<SertifikatView> createState() => _SertifikatViewState();
}

class _SertifikatViewState extends State<SertifikatView> {
  // Daftar sertifikat – diisi dari initialDaftar jika ada, atau dummy data.
  late List<SertifikatItem> _daftarSertifikat;

  @override
  void initState() {
    super.initState();
    _daftarSertifikat = widget.initialDaftar ??
        [
          SertifikatItem(
            label: 'Sertifikat',
            judul: 'Dasar Phyton',
            tanggalTerbit: 'Diterbitkan pada: 12 Mar 2026',
            tanggal: DateTime(2026, 3, 12),
          ),
          SertifikatItem(
            label: 'Sertifikat',
            judul: 'Dasar Phyton',
            tanggalTerbit: 'Diterbitkan pada: 01 Mar 2026',
            tanggal: DateTime(2026, 3, 1),
          ),
        ];
  }

  // State rentang tanggal terpilih (dari tanggal X sampai tanggal Y)
  DateTime? _startDate;
  DateTime? _endDate;

  static String _formatDateShort(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    final day = d.day.toString().padLeft(2, '0');
    final month = months[d.month - 1];
    return '$day $month ${d.year}';
  }

  List<SertifikatItem> get _filteredList {
    if (_startDate == null || _endDate == null) {
      return _daftarSertifikat;
    }
    return _daftarSertifikat.where((item) {
      final itemDate = DateTime(item.tanggal.year, item.tanggal.month, item.tanggal.day);
      final start = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
      final end = DateTime(_endDate!.year, _endDate!.month, _endDate!.day);
      return (itemDate.isAfter(start) || itemDate.isAtSameMomentAs(start)) &&
             (itemDate.isBefore(end) || itemDate.isAtSameMomentAs(end));
    }).toList();
  }

  void _onFooterTap(int idx) {
    if (idx == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileView()),
      );
    } else if (idx == 0) {
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

  /// Navigasi ke halaman Form Upload Sertifikat Baru (CRUD)
  void _handleUploadNavigation() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => UploadSertifikatView(
          daftarSertifikat: List.from(_daftarSertifikat),
          onDaftarChanged: (updated) {
            // Callback ini tidak akan dipanggil karena sudah pindah halaman,
            // tapi tetap disediakan untuk kebutuhan future.
          },
        ),
      ),
    );
  }

  void _handleDownload(SertifikatItem item) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Mengunduh sertifikat ${item.judul}...'),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Widget _themeDatePicker(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: AppColors.primary,
        ),
      ),
      child: child!,
    );
  }

  /// Tampilkan modal bottom sheet untuk filter tanggal (Dari - Sampai)
  void _showFilterModal() {
    DateTime? tempStart = _startDate;
    DateTime? tempEnd = _endDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (modalCtx, setModalState) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final oneYearAgo = DateTime(now.year - 1, now.month, now.day);
          final twoYearsAgo = DateTime(now.year - 2, now.month, now.day);

          bool isSameDay(DateTime? a, DateTime b) {
            if (a == null) return false;
            return a.year == b.year && a.month == b.month && a.day == b.day;
          }

          final bool isAllSelected = tempStart == null && tempEnd == null;
          final bool isOneYearSelected =
              isSameDay(tempStart, oneYearAgo) && isSameDay(tempEnd, today);
          final bool isTwoYearsSelected =
              isSameDay(tempStart, twoYearsAgo) && isSameDay(tempEnd, today);

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 18,
                bottom: MediaQuery.of(modalCtx).viewInsets.bottom + 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Header Modal ─────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Rentang Tanggal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.primary, size: 20),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pilih tanggal mulai sampai tanggal selesai sertifikat diterbitkan.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ── Input Tanggal: Dari Tanggal & Sampai Tanggal ─────────
                  Row(
                    children: [
                      // Kotak Dari Tanggal
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: modalCtx,
                              initialDate: tempStart ?? today,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                              builder: _themeDatePicker,
                            );
                            if (picked != null) {
                              setModalState(() {
                                tempStart = picked;
                                if (tempEnd != null && tempEnd!.isBefore(picked)) {
                                  tempEnd = picked;
                                }
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dari Tanggal',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 14,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        tempStart != null
                                            ? _formatDateShort(tempStart!)
                                            : 'Pilih...',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: tempStart != null
                                              ? AppColors.primary
                                              : Colors.grey.shade400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Kotak Sampai Tanggal
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: modalCtx,
                              initialDate: tempEnd ?? tempStart ?? today,
                              firstDate: tempStart ?? DateTime(2020),
                              lastDate: DateTime(2030),
                              builder: _themeDatePicker,
                            );
                            if (picked != null) {
                              setModalState(() {
                                tempEnd = picked;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sampai Tanggal',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.event_available_rounded,
                                      size: 15,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        tempEnd != null
                                            ? _formatDateShort(tempEnd!)
                                            : 'Pilih...',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: tempEnd != null
                                              ? AppColors.primary
                                              : Colors.grey.shade400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ── Tombol Buka Kalender Rentang Lengkap ───────────────────
                  OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: modalCtx,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        initialDateRange: (tempStart != null && tempEnd != null)
                            ? DateTimeRange(start: tempStart!, end: tempEnd!)
                            : DateTimeRange(
                                start: oneYearAgo,
                                end: today,
                              ),
                        builder: _themeDatePicker,
                      );
                      if (picked != null) {
                        setModalState(() {
                          tempStart = picked.start;
                          tempEnd = picked.end;
                        });
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.35),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    icon: const Icon(Icons.date_range_rounded, size: 16),
                    label: const Text(
                      'Pilih Rentang dari Kalender',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Preset Cepat ─────────────────────────────────────────
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      ActionChip(
                        label: const Text('Semua'),
                        backgroundColor: isAllSelected
                            ? AppColors.primary
                            : const Color(0xFFF6EFF1),
                        labelStyle: TextStyle(
                          color: isAllSelected
                              ? Colors.white
                              : AppColors.primary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          setModalState(() {
                            tempStart = null;
                            tempEnd = null;
                          });
                        },
                      ),
                      ActionChip(
                        label: const Text('1 Tahun'),
                        backgroundColor: isOneYearSelected
                            ? AppColors.primary
                            : const Color(0xFFF6EFF1),
                        labelStyle: TextStyle(
                          color: isOneYearSelected
                              ? Colors.white
                              : AppColors.primary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          setModalState(() {
                            tempStart = oneYearAgo;
                            tempEnd = today;
                          });
                        },
                      ),
                      ActionChip(
                        label: const Text('2 Tahun'),
                        backgroundColor: isTwoYearsSelected
                            ? AppColors.primary
                            : const Color(0xFFF6EFF1),
                        labelStyle: TextStyle(
                          color: isTwoYearsSelected
                              ? Colors.white
                              : AppColors.primary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          setModalState(() {
                            tempStart = twoYearsAgo;
                            tempEnd = today;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Tombol Terapkan & Reset ──────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _startDate = null;
                              _endDate = null;
                            });
                            Navigator.pop(ctx);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Reset Filter',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _startDate = tempStart;
                              _endDate = tempEnd;
                            });
                            Navigator.pop(ctx);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Terapkan Filter',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          // top: false agar header maroon full-bleed ke atas layar di belakang status bar
          // bottom: false karena footer menangani safe area sendiri
          top: false,
          bottom: false,
          child: Column(
            children: [
              // ── Header Maroon "Sertifikat & Portofolio" ─────────────────
              const _SertifikatHeader(),

              // ── Konten Scrollable ────────────────────────────────────────
              Expanded(
                child: LayoutBuilder(
                  builder: (ctx, constraints) {
                    // Padding horizontal proporsional (7.5% lebar layar, clamp 22–40)
                    // sama persis dengan Pre-Test, Post-Test, dan Beranda
                    final double hp =
                        (constraints.maxWidth * 0.075).clamp(22.0, 40.0);
                    final items = _filteredList;
                    final bool isFilterActive =
                        _startDate != null && _endDate != null;

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(hp, 14, hp, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── 1. Tombol Back Pill ────────────────────────────
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                                    size: 14,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // ── 2. Tombol "Upload Sertifikat Baru" (Full Width) ─
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: _handleUploadNavigation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Upload Sertifikat Baru',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── 3. Heading "Daftar sertifikat" + Tombol Filter ──
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Daftar sertifikat',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              InkWell(
                                onTap: _showFilterModal,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.tune_rounded,
                                        size: 18,
                                        color: isFilterActive
                                            ? AppColors.primary
                                            : AppColors.primary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isFilterActive ? 'Filter (Aktif)' : 'Filter',
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ── Badge Filter Aktif (jika ada rentang tanggal dipilih) ─
                          if (isFilterActive) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.date_range_rounded,
                                    size: 13,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${_formatDateShort(_startDate!)} - ${_formatDateShort(_endDate!)}',
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _startDate = null;
                                        _endDate = null;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 12),

                          // ── 4. Card List Sertifikat (Compact & Clean) ──────
                          if (items.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 36),
                              child: Center(
                                child: Text(
                                  'Tidak ada sertifikat pada rentang tanggal ini.',
                                  style: TextStyle(
                                    color: AppColors.primary.withValues(alpha: 0.6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 14),
                              itemBuilder: (ctx, idx) {
                                final item = items[idx];
                                return Container(
                                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.label,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        item.judul,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        item.tanggalTerbit,
                                        style: TextStyle(
                                          color: AppColors.primary.withValues(alpha: 0.7),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 38,
                                        child: ElevatedButton(
                                          onPressed: () => _handleDownload(item),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Unduh Sertifikat',
                                            style: TextStyle(
                                              fontSize: 13,
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

/// Header Maroon melengkung untuk halaman Sertifikat & Portofolio
class _SertifikatHeader extends StatelessWidget {
  const _SertifikatHeader();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double statusBarHeight = mediaQuery.viewPadding.top;
    final double hp = (mediaQuery.size.width * 0.075).clamp(22.0, 40.0);

    return Material(
      elevation: 4,
      shadowColor: AppColors.softShadow,
      color: AppColors.primary,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: statusBarHeight + 20,
          bottom: 22,
          left: hp,
          right: hp,
        ),
        child: const Center(
          child: Text(
            'Sertifikat & Portofolio',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }
}
