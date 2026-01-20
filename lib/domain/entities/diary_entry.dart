/// Diary Entry Entity
///
/// Core domain object representing a journal entry.
/// Immutable and contains no external dependencies.
class DiaryEntry {
  final String id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DiaryEntry({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a new entry with current timestamp
  factory DiaryEntry.create({
    required String id,
    required String content,
  }) {
    final now = DateTime.now();
    return DiaryEntry(
      id: id,
      content: content,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Copy with updated content
  DiaryEntry copyWith({
    String? content,
    DateTime? updatedAt,
  }) {
    return DiaryEntry(
      id: id,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Get preview text (first 1-2 lines, max 100 chars)
  String get preview {
    final lines = content.split('\n').where((line) => line.trim().isNotEmpty).take(2);
    final preview = lines.join(' ').trim();
    if (preview.length > 100) {
      return '${preview.substring(0, 100)}...';
    }
    return preview;
  }

  /// Check if entry is empty
  bool get isEmpty => content.trim().isEmpty;

  /// Check if entry is not empty
  bool get isNotEmpty => !isEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryEntry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^ content.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;

  @override
  String toString() {
    return 'DiaryEntry(id: $id, createdAt: $createdAt, preview: ${preview.substring(0, preview.length > 20 ? 20 : preview.length)}...)';
  }
}

