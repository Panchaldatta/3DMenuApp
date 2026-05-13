import 'package:flutter/material.dart';
import 'colors.dart';

final TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'Outfit',
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
    letterSpacing: -0.5,
  ),
  displayMedium: TextStyle(
    fontFamily: 'Outfit',
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  ),
  displaySmall: TextStyle(
    fontFamily: 'Outfit',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  ),
  titleLarge: TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurface,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.onSurface.withOpacity(0.8),
  ),
  labelLarge: TextStyle(
    fontFamily: 'Outfit',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: 1.1,
  ),
);
