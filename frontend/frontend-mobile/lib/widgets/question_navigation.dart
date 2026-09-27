import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Bottom row with Back / "Soal X/Y" / Next controls.
///
/// Back is disabled on the first question, Next is disabled on the
/// last question. Disabled state is shown with faded color and the
/// callback is not invoked.
class QuestionNavigation extends StatelessWidget {
  final int currentIndex; // 0-based
  final int total;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const QuestionNavigation({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.onBack,
    required this.onNext,
  });

  bool get _isFirst => currentIndex <= 0;
  bool get _isLast => currentIndex >= total - 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool compact = width < 340;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _NavButton(
          label: 'Back',
          icon: Icons.arrow_back,
          iconFirst: true,
          enabled: !_isFirst,
          onTap: onBack,
          compact: compact,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Soal ${currentIndex + 1}/$total',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
        _NavButton(
          label: 'Next',
          icon: Icons.arrow_forward,
          iconFirst: false,
          enabled: !_isLast,
          onTap: onNext,
          compact: compact,
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool iconFirst;
  final bool enabled;
  final VoidCallback onTap;
  final bool compact;

  const _NavButton({
    required this.label,
    required this.icon,
    required this.iconFirst,
    required this.enabled,
    required this.onTap,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = enabled ? AppColors.primary : AppColors.primaryFaded;

    final children = <Widget>[
      Icon(icon, size: 18, color: color),
      const SizedBox(width: 6),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ];

    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: enabled ? onTap : null,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color, width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: iconFirst ? children : children.reversed.toList(),
          ),
        ),
      ),
    );
  }
}
