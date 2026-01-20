import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Solity Typography
///
/// Sans-serif, human, rounded fonts.
/// Medium line-height for comfortable reading.
/// Readable at night with proper contrast.
class AppTypography {
  AppTypography._();

  // Base font family - Nunito is rounded and friendly
  static String get fontFamily => GoogleFonts.nunito().fontFamily!;

  // Display - for large headers
  static TextStyle displayLarge({Color? color}) => GoogleFonts.nunito(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.5,
  );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.3,
  );

  // Headings
  static TextStyle headlineLarge({Color? color}) => GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle headlineMedium({Color? color}) => GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle headlineSmall({Color? color}) => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
  );

  // Title
  static TextStyle titleLarge({Color? color}) => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle titleSmall({Color? color}) => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.5,
  );

  // Body - for diary entries (main content)
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.nunito(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textPrimary,
    height: 1.7, // Extra line height for comfortable reading
    letterSpacing: 0.2,
  );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.nunito(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textPrimary,
    height: 1.6,
  );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textSecondary,
    height: 1.5,
  );

  // Labels
  static TextStyle labelLarge({Color? color}) => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.3,
  );

  static TextStyle labelMedium({Color? color}) => GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.3,
  );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 0.4,
  );

  // Special - for date display
  static TextStyle dateDisplay({Color? color}) => GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // Special - for writing prompt
  static TextStyle prompt({Color? color}) => GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textSecondary,
    height: 1.5,
    fontStyle: FontStyle.italic,
  );

  // Special - for entry preview
  static TextStyle entryPreview({Color? color}) => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color ?? AppColors.textSecondary,
    height: 1.5,
  );
}

