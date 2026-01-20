import '../entities/app_settings.dart';

/// Settings Repository Interface
///
/// Abstract contract for settings data operations.
abstract class SettingsRepository {
  /// Get current app settings
  Future<AppSettings> getSettings();

  /// Save app settings
  Future<void> saveSettings(AppSettings settings);

  /// Stream of settings for reactive updates
  Stream<AppSettings> watchSettings();

  /// Reset to default settings
  Future<void> resetSettings();
}

