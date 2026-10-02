import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/theme/app_colors.dart';
import '../../widgets/custom_footer.dart';
import '../beranda/beranda_view.dart';
import '../profile/profile_view.dart';

/// Item data siswa untuk leaderboard
class LeaderboardUser {
  final int rank;
  final String nama;
  final int? score;

  const LeaderboardUser({
    required this.rank,
    required this.nama,
    this.score,
  });
}

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  // 0 = Keseluruhan, 1 = Permateri
  int _selectedTab = 0;

  // Selected sub-materi index (ketika tab Permateri dipilih)
  int _selectedMateriIndex = 0;

  final List<String> _materiList = [
    'MS Word',
    'MS Excel',
    'Power Point',
    'Windows 11',
    'Dasar Python',
  ];

  // Dummy data Top 3
  final LeaderboardUser _rank1 = const LeaderboardUser(
    rank: 1,
    nama: 'Appip',
    score: 100,
  );

  final LeaderboardUser _rank2 = const LeaderboardUser(
    rank: 2,
    nama: 'Agus',
    score: 96,
  );

  final LeaderboardUser _rank3 = const LeaderboardUser(
    rank: 3,
    nama: 'Sins',
    score: 90,
  );

  // Dummy data rank 4 ke bawah
  final List<LeaderboardUser> _rankList = const [
    LeaderboardUser(rank: 4, nama: 'Ahmad Fauzi', score: 88),
    LeaderboardUser(rank: 5, nama: 'Biolina Rahma', score: 87),
    LeaderboardUser(rank: 6, nama: 'Candra Kartika', score: 85),
    LeaderboardUser(rank: 7, nama: 'Dini Lestari', score: 84),
    LeaderboardUser(rank: 8, nama: 'Eko Prasetyo', score: 83),
    LeaderboardUser(rank: 9, nama: 'Fajar Nugroho', score: 82),
    LeaderboardUser(rank: 10, nama: 'Gita Saraswati', score: 80),
    LeaderboardUser(rank: 11, nama: 'Hadi Saputra', score: 79),
    LeaderboardUser(rank: 12, nama: 'Intan Permata', score: 78),
    LeaderboardUser(rank: 13, nama: 'Joko Susilo', score: 77),
    LeaderboardUser(rank: 14, nama: 'Kartika Sari', score: 75),
    LeaderboardUser(rank: 15, nama: 'Lukman Hakim', score: 74),
    LeaderboardUser(rank: 16, nama: 'Maya Indah', score: 73),
    LeaderboardUser(rank: 17, nama: 'Naufal Zaki', score: 72),
    LeaderboardUser(rank: 18, nama: 'Olivia Wijaya', score: 70),
    LeaderboardUser(rank: 19, nama: 'Pandu Dewanata', score: 69),
    LeaderboardUser(rank: 20, nama: 'Qori Amalia', score: 68),
  ];

  // User rank terpin di bawah
  final LeaderboardUser _currentUser = const LeaderboardUser(
    rank: 21,
    nama: 'Seto Son Horeg',
    score: 67,
  );

  void _onFooterTap(int idx) {
    if (idx == 1) return;

    if (idx == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const BerandaView(),
        ),
        (route) => false,
      );
    } else if (idx == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ProfileView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Padding horizontal proporsional sama persis dengan Pre-Test dan Post-Test
    final double horizontalPadding =
        (size.width * 0.075).clamp(22.0, 40.0);

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CustomFooter(
        currentIndex: 1,
        onTap: _onFooterTap,
      ),

      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),

        child: SafeArea(
          top: false,
          bottom: false,

          child: Column(
            children: [
              // ── Header Maroon ─────────────────────────────────────
              Container(
                width: double.infinity,
                color: AppColors.primary,

                child: SafeArea(
                  bottom: false,

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      16,
                      horizontalPadding,
                      24,
                    ),

                    child: const Column(
                      children: [
                        Text(
                          'Leaderboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'Peringkat siswa',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,

                  children: [
                    Positioned(
                      top: -10,
                      left: 0,
                      right: 0,
                      height: 50,

                      child: Container(
                        color: AppColors.primary,
                      ),
                    ),

                    // Container putih utama
                    Container(
                      width: double.infinity,
                      height: double.infinity,

                      decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),

                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          20,
                          horizontalPadding,
                          0,
                        ),

                        child: Column(
                          children: [
                            // ── Toggle Switch ───────────────────────
                            Container(
                              height: 44,
                              padding: const EdgeInsets.all(3),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),

                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),

                              child: Row(
                                children: [
                                  // Tab Keseluruhan
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedTab = 0;
                                        });
                                      },

                                      borderRadius:
                                          BorderRadius.circular(10),

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _selectedTab == 0
                                              ? AppColors.primary
                                              : Colors.transparent,

                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),

                                        alignment: Alignment.center,

                                        child: Text(
                                          'Keseluruhan',

                                          style: TextStyle(
                                            color: _selectedTab == 0
                                                ? Colors.white
                                                : AppColors.primary,

                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Tab Permateri
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedTab = 1;
                                        });
                                      },

                                      borderRadius:
                                          BorderRadius.circular(10),

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _selectedTab == 1
                                              ? AppColors.primary
                                              : Colors.transparent,

                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),

                                        alignment: Alignment.center,

                                        child: Text(
                                          'Permateri',

                                          style: TextStyle(
                                            color: _selectedTab == 1
                                                ? Colors.white
                                                : AppColors.primary,

                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ── Sub-Filter Pills ─────────────────────
                            if (_selectedTab == 1) ...[
                              const SizedBox(height: 14),

                              SizedBox(
                                height: 32,

                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _materiList.length,

                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),

                                  itemBuilder: (ctx, idx) {
                                    final isSelected =
                                        idx == _selectedMateriIndex;

                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedMateriIndex = idx;
                                        });
                                      },

                                      borderRadius:
                                          BorderRadius.circular(8),

                                      child: Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),

                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primary
                                              : const Color(0xFFF1EFF1),

                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),

                                        child: Text(
                                          _materiList[idx],

                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : AppColors.primary
                                                    .withValues(alpha: 0.65),

                                            fontSize: 12,

                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],

                            const SizedBox(height: 18),

                            // ── Top 3 Podium Section ─────────────────
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,

                              child: SizedBox(
                                height: 130,

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,

                                  children: [
                                    // Rank 2
                                    _PodiumBar(
                                      user: _rank2,
                                      barHeight: 70,
                                      width: 84,
                                    ),

                                    const SizedBox(width: 12),

                                    // Rank 1
                                    _PodiumBar(
                                      user: _rank1,
                                      barHeight: 96,
                                      width: 90,
                                    ),

                                    const SizedBox(width: 12),

                                    // Rank 3
                                    _PodiumBar(
                                      user: _rank3,
                                      barHeight: 52,
                                      width: 84,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // ── List Rank 4 ke bawah ─────────────────
                            Expanded(
                              child: ListView.separated(
                                physics:
                                    const BouncingScrollPhysics(),

                                padding:
                                    const EdgeInsets.only(bottom: 12),

                                itemCount: _rankList.length,

                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),

                                itemBuilder: (ctx, idx) {
                                  final item = _rankList[idx];

                                  return Container(
                                    height: 46,

                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius:
                                          BorderRadius.circular(12),

                                      border: Border.all(
                                        color: AppColors.primary,
                                        width: 1.2,
                                      ),
                                    ),

                                    child: Row(
                                      children: [
                                        Text(
                                          '${item.rank}',

                                          style: const TextStyle(
                                            color:
                                                AppColors.primary,
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(width: 16),

                                        Expanded(
                                          child: Text(
                                            item.nama,

                                            style: const TextStyle(
                                              color:
                                                  AppColors.primary,
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),

                                            maxLines: 1,
                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            // ── Pinned Current User Rank Bar ─────────
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                                top: 4,
                              ),

                              height: 48,

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),

                              decoration: BoxDecoration(
                                color: AppColors.primary,

                                borderRadius:
                                    BorderRadius.circular(12),

                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),

                                    blurRadius: 8,

                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),

                              child: Row(
                                children: [
                                  Text(
                                    '${_currentUser.rank}',

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  Expanded(
                                    child: Text(
                                      _currentUser.nama,

                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),

                                      maxLines: 1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget Podium Bar tunggal untuk Top 3
class _PodiumBar extends StatelessWidget {
  final LeaderboardUser user;
  final double barHeight;
  final double width;

  const _PodiumBar({
    required this.user,
    required this.barHeight,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,

      children: [
        // Nama siswa
        SizedBox(
          width: width + 10,

          child: Text(
            user.nama,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),

            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(height: 6),

        // Batang Podium Maroon
        Container(
          width: width,
          height: barHeight,

          decoration: const BoxDecoration(
            color: AppColors.primary,

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),

          child: Center(
            child: Text(
              '${user.rank}',

              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

