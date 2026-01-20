import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

/// Solity App Theme
///
/// Three modes: Light, Dark, Dim
/// All modes maintain the calm, private feeling.
class AppTheme {
  AppTheme._();

  // Light Theme - Default
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.accent,
      onSecondary: AppColors.textOnPrimary,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    ),
    textTheme: _buildTextTheme(AppColors.textPrimary, AppColors.textSecondary),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      margin: EdgeInsets.zero,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingMd,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingMd,
      ),
      hintStyle: GoogleFonts.nunito(
        color: AppColors.textTertiary,
        fontSize: 15,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerLight,
      thickness: 1,
      space: 1,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.textTertiary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: 0.3);
        }
        return AppColors.dividerLight;
      }),
    ),
  );

  // Dark Theme
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accentLight,
      onPrimary: AppColors.backgroundDark,
      secondary: AppColors.accent,
      onSecondary: AppColors.textOnPrimary,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    ),
    textTheme: _buildTextTheme(AppColors.textPrimaryDark, AppColors.textSecondaryDark),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      margin: EdgeInsets.zero,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentLight,
      foregroundColor: AppColors.backgroundDark,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentLight,
        foregroundColor: AppColors.backgroundDark,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingMd,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentLight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: const BorderSide(color: AppColors.accentLight, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingMd,
      ),
      hintStyle: GoogleFonts.nunito(
        color: AppColors.textSecondaryDark,
        fontSize: 15,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: 1,
      space: 1,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.accentLight,
      unselectedItemColor: AppColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accentLight;
        }
        return AppColors.textSecondaryDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accentLight.withValues(alpha: 0.3);
        }
        return AppColors.dividerDark;
      }),
    ),
  );

  // Dim Theme (for night reading - even darker)
  static ThemeData get dim => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDim,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: AppColors.backgroundDim,
      secondary: AppColors.accent,
      onSecondary: AppColors.textOnPrimary,
      surface: AppColors.surfaceDim,
      onSurface: AppColors.textPrimaryDim,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    ),
    textTheme: _buildTextTheme(AppColors.textPrimaryDim, AppColors.textSecondaryDim),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDim,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryDim),
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDim,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardDim,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      margin: EdgeInsets.zero,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.backgroundDim,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.backgroundDim,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingMd,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDim,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingMd,
      ),
      hintStyle: GoogleFonts.nunito(
        color: AppColors.textSecondaryDim,
        fontSize: 15,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.dividerDark.withValues(alpha: 0.5),
      thickness: 1,
      space: 1,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDim,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textSecondaryDim,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent;
        }
        return AppColors.textSecondaryDim;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent.withValues(alpha: 0.3);
        }
        return AppColors.dividerDark.withValues(alpha: 0.5);
      }),
    ),
  );

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: GoogleFonts.nunito(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      displayMedium: GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      displaySmall: GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.3,
      ),
      headlineLarge: GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      headlineMedium: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      headlineSmall: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
        height: 1.4,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.5,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.5,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondary,
        height: 1.4,
      ),
    );
  }
}

/// Theme Mode Enum for Solity
enum SolityThemeMode {
  light,
  dark,
  dim,
}

extension SolityThemeModeExtension on SolityThemeMode {
  String get displayName {
    switch (this) {
      case SolityThemeMode.light:
        return 'Light';
      case SolityThemeMode.dark:
        return 'Dark';
      case SolityThemeMode.dim:
        return 'Dim';
    }
  }

  ThemeData get themeData {
    switch (this) {
      case SolityThemeMode.light:
        return AppTheme.light;
      case SolityThemeMode.dark:
        return AppTheme.dark;
      case SolityThemeMode.dim:
        return AppTheme.dim;
    }
  }
}

