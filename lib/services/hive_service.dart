import 'package:hive_flutter/hive_flutter.dart';
import '../data/models/diary_entry_model.dart';

/// Hive Database Service
///
/// Handles initialization and management of local storage.
class HiveService {
  HiveService._();

  static bool _initialized = false;

  /// Initialize Hive
  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DiaryEntryModelAdapter());
    }

    _initialized = true;
  }

  /// Close all boxes
  static Future<void> close() async {
    await Hive.close();
  }

  /// Clear all data (for debugging)
  static Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }
}

