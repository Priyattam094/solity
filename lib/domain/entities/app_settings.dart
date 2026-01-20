import '../../core/theme/app_theme.dart';

/// App Settings Entity
///
/// User preferences for appearance and privacy.
class AppSettings {
  final SolityThemeMode themeMode;
  final bool appLockEnabled;
  final double fontSize;
  final bool hidePreviewInRecents;

  const AppSettings({
    this.themeMode = SolityThemeMode.light,
    this.appLockEnabled = false,
    this.fontSize = 1.0, // 1.0 = normal, 0.85 = small, 1.15 = large
    this.hidePreviewInRecents = true,
  });

  AppSettings copyWith({
    SolityThemeMode? themeMode,
    bool? appLockEnabled,
    double? fontSize,
    bool? hidePreviewInRecents,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      fontSize: fontSize ?? this.fontSize,
      hidePreviewInRecents: hidePreviewInRecents ?? this.hidePreviewInRecents,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'appLockEnabled': appLockEnabled,
      'fontSize': fontSize,
      'hidePreviewInRecents': hidePreviewInRecents,
    };
  }

  /// Create from JSON map
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: SolityThemeMode.values[json['themeMode'] as int? ?? 0],
      appLockEnabled: json['appLockEnabled'] as bool? ?? false,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 1.0,
      hidePreviewInRecents: json['hidePreviewInRecents'] as bool? ?? true,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode &&
          appLockEnabled == other.appLockEnabled &&
          fontSize == other.fontSize &&
          hidePreviewInRecents == other.hidePreviewInRecents;

  @override
  int get hashCode =>
      themeMode.hashCode ^
      appLockEnabled.hashCode ^
      fontSize.hashCode ^
      hidePreviewInRecents.hashCode;
}

