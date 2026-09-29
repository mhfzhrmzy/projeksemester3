import 'package:flutter/material.dart';
import '../theme/auth_colors.dart';

/// Circular avatar icon shown on the Login & Register screens.
/// Matches the exact circular maroon profile silhouette logo
/// (circular stroke border, solid circular head, and smooth shoulder curve)
/// with a natural soft shadow.
class AuthAvatarIcon extends StatelessWidget {
  final double size;
  const AuthAvatarIcon({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: kMaroon.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/auth_avatar.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // High-precision vector fallback if asset is unavailable
            return CustomPaint(
              size: Size(size, size),
              painter: const _ProfileAvatarPainter(color: kMaroon),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileAvatarPainter extends CustomPainter {
  final Color color;

  const _ProfileAvatarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // ── 1. Background putih lingkaran ───────────────────────────
    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawCircle(Offset(cx, cy), r, bgPaint);

    // ── 2. Lingkaran luar (stroke) maroon ────────────────────────
    final strokeW = size.width * (10.0 / 176.0);
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..isAntiAlias = true;
    canvas.drawCircle(Offset(cx, cy), r - (strokeW / 2), strokePaint);

    // ── 3. Kepala (Lingkaran solid maroon) ───────────────────────
    final headR = size.width * (33.0 / 176.0);
    final headCenterY = size.height * (66.0 / 176.0);
    canvas.drawCircle(Offset(cx, headCenterY), headR, fillPaint);

    // ── 4. Bahu / Torso (Kurva lengkung simetris di bagian bawah) ──
    final innerR = r - strokeW;
    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: innerR)),
    );

    final scale = size.width / 176.0;
    final shoulderPath = Path();
    shoulderPath.moveTo(15.0 * scale, 160.0 * scale);
    shoulderPath.cubicTo(
      48.0 * scale,
      122.0 * scale,
      68.0 * scale,
      110.0 * scale,
      88.0 * scale,
      110.0 * scale,
    );
    shoulderPath.cubicTo(
      108.0 * scale,
      110.0 * scale,
      128.0 * scale,
      122.0 * scale,
      161.0 * scale,
      160.0 * scale,
    );
    shoulderPath.lineTo(176.0 * scale, 176.0 * scale);
    shoulderPath.lineTo(0.0, 176.0 * scale);
    shoulderPath.close();

    canvas.drawPath(shoulderPath, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ProfileAvatarPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
