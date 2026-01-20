import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Settings Repository Implementation
///
/// Uses flutter_secure_storage for encrypted local storage.
class SettingsRepositoryImpl implements SettingsRepository {
  static const String _settingsKey = 'solity_settings';
  final FlutterSecureStorage _storage;
  final StreamController<AppSettings> _settingsController =
      StreamController<AppSettings>.broadcast();

  SettingsRepositoryImpl(this._storage);

  /// Initialize the repository
  static Future<SettingsRepositoryImpl> init() async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    return SettingsRepositoryImpl(storage);
  }

  @override
  Future<AppSettings> getSettings() async {
    try {
      final jsonString = await _storage.read(key: _settingsKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return AppSettings.fromJson(json);
      }
    } catch (_) {
      // Return default settings on error
    }
    return const AppSettings();
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _storage.write(key: _settingsKey, value: jsonString);
    _settingsController.add(settings);
  }

  @override
  Stream<AppSettings> watchSettings() {
    return _settingsController.stream;
  }

  @override
  Future<void> resetSettings() async {
    await _storage.delete(key: _settingsKey);
    _settingsController.add(const AppSettings());
  }

  /// Dispose resources
  void dispose() {
    _settingsController.close();
  }
}

