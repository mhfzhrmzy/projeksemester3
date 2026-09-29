import 'package:flutter/material.dart';
import '../theme/auth_colors.dart';

/// Circular avatar icon shown on the Login & Register screens.
/// Displays a clean white circle with a soft natural shadow,
/// featuring the signature maroon minimalist silhouette (circular head + curved torso).
class AuthAvatarIcon extends StatelessWidget {
  final double size;
  const AuthAvatarIcon({super.key, this.size = 74});

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
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: kMaroon.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size, size),
          painter: const _ProfileAvatarPainter(color: kMaroon),
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
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // ── Proporsi simetris terkalibrasi presisi terhadap lingkaran luar ──
    // Margin seragam ~7.1px ke seluruh sisi border lingkaran (atas, bawah, kiri, kanan)
    final headRadius = size.width * 0.21;
    final gap = size.height * 0.055;
    final halfW = size.width * 0.345;
    final halfH = size.height * 0.165;

    final figureHeight = (2 * headRadius) + gap + (2 * halfH);

    // Titik awal vertikal agar seluruh figur presisi di titik tengah vertikal (cy)
    final topY = cy - (figureHeight / 2);
    final headCenterY = topY + headRadius;
    final bodyCenterY = topY + (2 * headRadius) + gap + halfH;

    // ── 1. Kepala (Lingkaran) ───────────────────────────────────
    canvas.drawCircle(Offset(cx, headCenterY), headRadius, paint);

    // ── 2. Badan / Bahu (Lengkung horizontal simetris) ──────────
    // Radius lengkungan agar kurva bawah sejajar harmonis dengan kurvatur lingkaran luar
    final r = (halfW * halfW + halfH * halfH) / (2 * halfH);

    final path = Path();
    path.moveTo(cx - halfW, bodyCenterY);
    // Lengkung atas
    path.arcToPoint(
      Offset(cx + halfW, bodyCenterY),
      radius: Radius.circular(r),
      clockwise: true,
    );
    // Lengkung bawah kembali ke titik awal
    path.arcToPoint(
      Offset(cx - halfW, bodyCenterY),
      radius: Radius.circular(r),
      clockwise: true,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ProfileAvatarPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

