import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Card that displays the current question text, and, when present,
/// a monospace code block above it.
///
/// Deliberately has NO fixed height: it wraps its content so long
/// questions / code snippets simply make the card taller.
class QuestionCard extends StatelessWidget {
  final String questionText;
  final String? code;

  const QuestionCard({
    super.key,
    required this.questionText,
    this.code,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double fontSize = width > 600 ? 16 : 15;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.softShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Soal:',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ),
          if (code != null) ...[
            const SizedBox(height: 10),
            _CodeBlock(code: code!),
            const SizedBox(height: 12),
          ] else
            const SizedBox(height: 6),
          Text(
            questionText,
            softWrap: true,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: fontSize,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Monospace, horizontally-scrollable code block used to display
/// Python snippets inside a question card without causing overflow
/// on narrow screens.
class _CodeBlock extends StatelessWidget {
  final String code;

  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.border.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
            color: AppColors.primaryDark,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
