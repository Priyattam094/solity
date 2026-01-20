import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'data/models/diary_entry_model.dart';
import 'data/repositories/diary_repository_impl.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'presentation/providers/diary_providers.dart';
import 'presentation/providers/settings_providers.dart';

/// Solity - My Digital Diary
///
/// Private. Offline. No Account.
/// Your inner world stays on your device.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(DiaryEntryModelAdapter());
  }

  // Initialize repositories
  final diaryRepository = await DiaryRepositoryImpl.init();
  final settingsRepository = await SettingsRepositoryImpl.init();

  // Load initial settings
  final initialSettings = await settingsRepository.getSettings();

  // Run app with providers
  runApp(
    ProviderScope(
      overrides: [
        diaryRepositoryProvider.overrideWithValue(diaryRepository),
        settingsRepositoryProvider.overrideWithValue(settingsRepository),
        settingsNotifierProvider.overrideWith(
          (ref) => SettingsNotifier(settingsRepository, initialSettings),
        ),
      ],
      child: const SolityApp(),
    ),
  );
}
