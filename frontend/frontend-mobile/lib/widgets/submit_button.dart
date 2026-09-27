import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Full-width Submit button.
///
/// Enabled (maroon, tappable) only when [enabled] is true; otherwise
/// rendered in a faded color and taps are ignored.
class SubmitButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = enabled ? AppColors.primary : AppColors.primaryFaded;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        elevation: enabled ? 4 : 0,
        shadowColor: AppColors.softShadow,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: enabled ? onPressed : null,
          child: const Center(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
