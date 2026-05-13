import 'package:flutter/material.dart';
import 'colors.dart';

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.neonBlue, AppColors.neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient background = LinearGradient(
    colors: [Color(0xFF0A0A0A), Color(0xFF111130)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient card = LinearGradient(
    colors: [Color(0xFF1E1E2E), Color(0xFF111111)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
