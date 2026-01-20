import 'package:flutter/material.dart';

/// Solity Dimensions
///
/// Consistent spacing, radii, and shadows.
/// Everything feels like paper, not tiles.
class AppDimensions {
  AppDimensions._();

  // Spacing - generous for breathing room
  static const double spacingXxs = 4.0;
  static const double spacingXs = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;
  static const double spacingXxxl = 64.0;

  // Border Radius - soft, rounded, friendly
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Card specific
  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double inputRadius = 12.0;

  // Padding - for content areas
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: spacingLg,
    vertical: spacingMd,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(spacingMd);

  static const EdgeInsets writingPadding = EdgeInsets.symmetric(
    horizontal: spacingXl,
    vertical: spacingLg,
  );

  // Shadows - very soft, paper-like
  static List<BoxShadow> get shadowSoft => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.02),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowMedium => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get shadowElevated => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];

  // Icon sizes
  static const double iconSizeSm = 18.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;

  // Touch targets - large for touch-first design
  static const double touchTargetMin = 48.0;
  static const double buttonHeight = 56.0;
  static const double fabSize = 64.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 250);
  static const Duration animationSlow = Duration(milliseconds: 400);

  // Screen breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
}

