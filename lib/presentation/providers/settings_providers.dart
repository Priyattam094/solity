import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../core/theme/app_theme.dart';

/// Provider for SettingsRepository
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  throw UnimplementedError('settingsRepositoryProvider must be overridden');
});

/// Provider for current app settings
final appSettingsProvider = FutureProvider<AppSettings>((ref) async {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.getSettings();
});

/// Notifier for managing app settings
class SettingsNotifier extends StateNotifier<AppSettings> {
  final SettingsRepository _repository;

  SettingsNotifier(this._repository, AppSettings initialSettings) : super(initialSettings);

  /// Update theme mode
  Future<void> setThemeMode(SolityThemeMode mode) async {
    final newSettings = state.copyWith(themeMode: mode);
    await _repository.saveSettings(newSettings);
    state = newSettings;
  }

  /// Toggle app lock
  Future<void> setAppLockEnabled(bool enabled) async {
    final newSettings = state.copyWith(appLockEnabled: enabled);
    await _repository.saveSettings(newSettings);
    state = newSettings;
  }

  /// Update font size
  Future<void> setFontSize(double size) async {
    final newSettings = state.copyWith(fontSize: size);
    await _repository.saveSettings(newSettings);
    state = newSettings;
  }

  /// Toggle hide preview in recents
  Future<void> setHidePreviewInRecents(bool hide) async {
    final newSettings = state.copyWith(hidePreviewInRecents: hide);
    await _repository.saveSettings(newSettings);
    state = newSettings;
  }

  /// Reset all settings
  Future<void> resetSettings() async {
    await _repository.resetSettings();
    state = const AppSettings();
  }

  /// Update all settings at once
  Future<void> updateSettings(AppSettings settings) async {
    await _repository.saveSettings(settings);
    state = settings;
  }
}

/// Provider for SettingsNotifier
final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  throw UnimplementedError('settingsNotifierProvider must be overridden');
});

/// Provider for current theme mode
final themeModeProvider = Provider<SolityThemeMode>((ref) {
  final settings = ref.watch(settingsNotifierProvider);
  return settings.themeMode;
});

/// Provider for current theme data
final themeDataProvider = Provider((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode.themeData;
});

