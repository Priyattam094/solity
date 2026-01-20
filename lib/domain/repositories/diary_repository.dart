import '../entities/diary_entry.dart';

/// Diary Repository Interface
///
/// Abstract contract for diary data operations.
/// Implementation details are in the data layer.
abstract class DiaryRepository {
  /// Get all entries, sorted by date (newest first)
  Future<List<DiaryEntry>> getAllEntries();

  /// Get a single entry by ID
  Future<DiaryEntry?> getEntry(String id);

  /// Get entries for a specific date
  Future<List<DiaryEntry>> getEntriesByDate(DateTime date);

  /// Create a new entry
  Future<DiaryEntry> createEntry(String content);

  /// Update an existing entry
  Future<DiaryEntry> updateEntry(String id, String content);

  /// Delete an entry
  Future<void> deleteEntry(String id);

  /// Search entries by content
  Future<List<DiaryEntry>> searchEntries(String query);

  /// Export all entries as formatted text
  Future<String> exportAsText();

  /// Export all entries as JSON
  Future<String> exportAsJson();

  /// Get entry count
  Future<int> getEntryCount();

  /// Get the most recent entry
  Future<DiaryEntry?> getLastEntry();

  /// Stream of all entries for reactive updates
  Stream<List<DiaryEntry>> watchAllEntries();
}

