import 'package:hive/hive.dart';

part 'diary_entry_model.g.dart';

/// Hive model for diary entries
///
/// TypeId 0 is reserved for DiaryEntryModel
@HiveType(typeId: 0)
class DiaryEntryModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final DateTime updatedAt;

  DiaryEntryModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });
}

