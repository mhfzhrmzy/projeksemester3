import 'package:flutter/material.dart';

/// Centralized color palette matched to the Pre-Test / Post-Test
/// reference designs. Keep the palette small and consistent.
class AppColors {
  AppColors._();

  /// Primary maroon / dark red used for header, submit button and text.
  static const Color primary = Color(0xFF7D1238);

  /// Slightly darker shade used for shadows / pressed states.
  static const Color primaryDark = Color(0xFF5E0D2A);

  /// Warm gray used to mark a selected answer option — harmonious with maroon.
  static const Color selected = Color(0xFFE8E4E6);

  /// Border color shown on selected answer cards.
  static const Color selectedBorder = Color(0xFFB8A8AF);

  /// Border color for unselected answer cards / question card.
  static const Color border = Color(0xFFEDE1E5);

  /// Page background.
  static const Color background = Colors.white;

  /// Disabled / faded version of primary, used for the Submit button
  /// and the Back/Next controls when they are not actionable.
  static Color primaryFaded = primary.withOpacity(0.35);

  /// Soft shadow color used across header, cards and buttons.
  static Color softShadow = Colors.black.withOpacity(0.08);
}
