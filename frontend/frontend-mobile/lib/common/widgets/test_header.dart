import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

/// Fixed maroon header with a large rounded bottom edge and a soft
/// shadow, matching the Pre-Test / Post-Test reference design.
///
/// This widget must never be placed inside a scroll view — it is
/// meant to stay pinned at the top of the screen.
///
/// The maroon background is full-bleed: it fills the area behind the
/// status bar too (matching the reference design, which shows a solid
/// maroon block reaching the very top of the phone). To keep the
/// battery/clock/signal icons readable on top of that dark color, the
/// status bar icon style is switched to light (white). The title text
/// itself is pushed well below the status bar row using generous top
/// padding (device status bar height + extra buffer).
class TestHeader extends StatelessWidget {
  final String title;

  const TestHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Real status bar height reported by the OS (battery/clock/signal
    // row). Using viewPadding keeps this accurate even in edge-to-edge
    // mode on newer Android versions.
    final double statusBarHeight = mediaQuery.viewPadding.top;
    final double width = mediaQuery.size.width;
    final double horizontalPadding = width > 600 ? 32 : 20;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Light (white) icons read clearly against the dark maroon
      // background behind the status bar.
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Material(
        elevation: 6,
        shadowColor: AppColors.softShadow,
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            // Clear the status bar row, then push the title further
            // down for generous breathing room below the icons.
            top: statusBarHeight + 36,
            bottom: 32,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
