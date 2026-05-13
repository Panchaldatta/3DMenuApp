import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    Key? key,
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.surfaceCard.withOpacity(0.4),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppColors.neonBlue.withOpacity(0.2), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.neonBlue.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
