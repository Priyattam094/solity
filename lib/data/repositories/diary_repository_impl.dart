import 'dart:async';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/diary_entry.dart';
import '../../domain/repositories/diary_repository.dart';
import '../../core/utils/date_formatter.dart';
import '../models/diary_entry_model.dart';

/// Diary Repository Implementation using Hive
///
/// All data stays local on the device.
class DiaryRepositoryImpl implements DiaryRepository {
  static const String _boxName = 'diary_entries';
  final Box<DiaryEntryModel> _box;
  final Uuid _uuid = const Uuid();

  DiaryRepositoryImpl(this._box);

  /// Initialize the repository
  static Future<DiaryRepositoryImpl> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DiaryEntryModelAdapter());
    }
    final box = await Hive.openBox<DiaryEntryModel>(_boxName);
    return DiaryRepositoryImpl(box);
  }

  /// Convert model to entity
  DiaryEntry _toEntity(DiaryEntryModel model) {
    return DiaryEntry(
      id: model.id,
      content: model.content,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  /// Convert entity to model
  DiaryEntryModel _toModel(DiaryEntry entry) {
    return DiaryEntryModel(
      id: entry.id,
      content: entry.content,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }

  @override
  Future<List<DiaryEntry>> getAllEntries() async {
    final entries = _box.values.map(_toEntity).toList();
    // Sort by creation date, newest first
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  @override
  Future<DiaryEntry?> getEntry(String id) async {
    final model = _box.get(id);
    return model != null ? _toEntity(model) : null;
  }

  @override
  Future<List<DiaryEntry>> getEntriesByDate(DateTime date) async {
    final entries = await getAllEntries();
    return entries.where((entry) => DateFormatter.isSameDay(entry.createdAt, date)).toList();
  }

  @override
  Future<DiaryEntry> createEntry(String content) async {
    final entry = DiaryEntry.create(
      id: _uuid.v4(),
      content: content,
    );
    await _box.put(entry.id, _toModel(entry));
    return entry;
  }

  @override
  Future<DiaryEntry> updateEntry(String id, String content) async {
    final existing = await getEntry(id);
    if (existing == null) {
      throw Exception('Entry not found: $id');
    }
    final updated = existing.copyWith(content: content);
    await _box.put(id, _toModel(updated));
    return updated;
  }

  @override
  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<DiaryEntry>> searchEntries(String query) async {
    if (query.trim().isEmpty) {
      return getAllEntries();
    }
    final lowerQuery = query.toLowerCase();
    final entries = await getAllEntries();
    return entries.where((entry) =>
      entry.content.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  @override
  Future<String> exportAsText() async {
    final entries = await getAllEntries();
    final buffer = StringBuffer();

    buffer.writeln('═══════════════════════════════════════');
    buffer.writeln('         SOLITY - MY DIGITAL DIARY');
    buffer.writeln('═══════════════════════════════════════');
    buffer.writeln();
    buffer.writeln('Exported on: ${DateFormatter.writingDate(DateTime.now())}');
    buffer.writeln('Total entries: ${entries.length}');
    buffer.writeln();
    buffer.writeln('───────────────────────────────────────');
    buffer.writeln();

    for (final entry in entries) {
      buffer.writeln('📅 ${DateFormatter.writingDate(entry.createdAt)}');
      buffer.writeln();
      buffer.writeln(entry.content);
      buffer.writeln();
      buffer.writeln('───────────────────────────────────────');
      buffer.writeln();
    }

    return buffer.toString();
  }

  @override
  Future<String> exportAsJson() async {
    final entries = await getAllEntries();
    final data = {
      'app': 'Solity',
      'exportedAt': DateTime.now().toIso8601String(),
      'entryCount': entries.length,
      'entries': entries.map((e) => {
        'id': e.id,
        'content': e.content,
        'createdAt': e.createdAt.toIso8601String(),
        'updatedAt': e.updatedAt.toIso8601String(),
      }).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  @override
  Future<int> getEntryCount() async {
    return _box.length;
  }

  @override
  Future<DiaryEntry?> getLastEntry() async {
    final entries = await getAllEntries();
    return entries.isNotEmpty ? entries.first : null;
  }

  @override
  Stream<List<DiaryEntry>> watchAllEntries() {
    return _box.watch().map((_) {
      final entries = _box.values.map(_toEntity).toList();
      entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return entries;
    });
  }
}

