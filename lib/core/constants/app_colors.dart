import 'package:flutter/material.dart';

/// Solity Color Palette
///
/// Designed for calm, trust, and privacy.
/// No harsh whites or pure blacks - everything feels soft.
class AppColors {
  AppColors._();

  // Primary - Soft Deep Blue (trust, privacy, depth)
  static const Color primary = Color(0xFF1E3A5F);
  static const Color primaryLight = Color(0xFF2C4A6E);
  static const Color primaryDark = Color(0xFF152A45);

  // Text Colors - Warm Gray (not harsh black)
  static const Color textPrimary = Color(0xFF3A3A3A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF9A9A9A);
  static const Color textOnPrimary = Color(0xFFFAF9F7);

  // Background Colors - Muted Off-White (not harsh white)
  static const Color backgroundLight = Color(0xFFFAF9F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF1A1A1E);
  static const Color surfaceDark = Color(0xFF242428);
  static const Color cardDark = Color(0xFF2C2C32);
  static const Color textPrimaryDark = Color(0xFFE8E8E8);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Dim Theme Colors (for night reading)
  static const Color backgroundDim = Color(0xFF121214);
  static const Color surfaceDim = Color(0xFF1A1A1C);
  static const Color cardDim = Color(0xFF222224);
  static const Color textPrimaryDim = Color(0xFFD0D0D0);
  static const Color textSecondaryDim = Color(0xFF8A8A8A);

  // Accent Colors (subtle, for selected states only)
  static const Color accent = Color(0xFF5B8CB8);
  static const Color accentLight = Color(0xFF7BA8D0);

  // Semantic Colors (kept muted)
  static const Color success = Color(0xFF5A8A6E);
  static const Color error = Color(0xFFC67B7B);
  static const Color warning = Color(0xFFD4A574);

  // Shadow Colors
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x14000000);

  // Divider
  static const Color dividerLight = Color(0xFFEEEDEB);
  static const Color dividerDark = Color(0xFF3A3A3E);
}

