import 'package:flutter/material.dart';

/// Circular avatar icon shown on the Login & Register screens.
class AuthAvatarIcon extends StatelessWidget {
  const AuthAvatarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.account_circle,
        size: 88,
        color: Colors.black87,
      ),
    );
  }
}
