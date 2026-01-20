import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/diary_entry.dart';
import '../../domain/repositories/diary_repository.dart';

/// Provider for DiaryRepository
final diaryRepositoryProvider = Provider<DiaryRepository>((ref) {
  throw UnimplementedError('diaryRepositoryProvider must be overridden');
});

/// Provider for all diary entries
final diaryEntriesProvider = FutureProvider<List<DiaryEntry>>((ref) async {
  final repository = ref.watch(diaryRepositoryProvider);
  return repository.getAllEntries();
});

/// Provider for a single entry by ID
final diaryEntryProvider = FutureProvider.family<DiaryEntry?, String>((ref, id) async {
  final repository = ref.watch(diaryRepositoryProvider);
  return repository.getEntry(id);
});

/// Provider for the last entry
final lastEntryProvider = FutureProvider<DiaryEntry?>((ref) async {
  final repository = ref.watch(diaryRepositoryProvider);
  return repository.getLastEntry();
});

/// Provider for entry count
final entryCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(diaryRepositoryProvider);
  return repository.getEntryCount();
});

/// Notifier for managing diary entries with mutations
class DiaryNotifier extends StateNotifier<AsyncValue<List<DiaryEntry>>> {
  final DiaryRepository _repository;
  final Ref _ref;

  DiaryNotifier(this._repository, this._ref) : super(const AsyncValue.loading()) {
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    state = const AsyncValue.loading();
    try {
      final entries = await _repository.getAllEntries();
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Refresh entries
  Future<void> refresh() async {
    await _loadEntries();
  }

  /// Create a new entry
  Future<DiaryEntry> createEntry(String content) async {
    final entry = await _repository.createEntry(content);
    await _loadEntries();
    // Invalidate related providers
    _ref.invalidate(lastEntryProvider);
    _ref.invalidate(entryCountProvider);
    return entry;
  }

  /// Update an entry
  Future<DiaryEntry> updateEntry(String id, String content) async {
    final entry = await _repository.updateEntry(id, content);
    await _loadEntries();
    return entry;
  }

  /// Delete an entry
  Future<void> deleteEntry(String id) async {
    await _repository.deleteEntry(id);
    await _loadEntries();
    _ref.invalidate(lastEntryProvider);
    _ref.invalidate(entryCountProvider);
  }

  /// Search entries
  Future<List<DiaryEntry>> searchEntries(String query) async {
    return _repository.searchEntries(query);
  }

  /// Export as text
  Future<String> exportAsText() async {
    return _repository.exportAsText();
  }

  /// Export as JSON
  Future<String> exportAsJson() async {
    return _repository.exportAsJson();
  }
}

/// Provider for DiaryNotifier
final diaryNotifierProvider = StateNotifierProvider<DiaryNotifier, AsyncValue<List<DiaryEntry>>>((ref) {
  final repository = ref.watch(diaryRepositoryProvider);
  return DiaryNotifier(repository, ref);
});

