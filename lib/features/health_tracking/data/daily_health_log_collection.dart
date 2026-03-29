import 'package:isar/isar.dart';

part 'daily_health_log_collection.g.dart';

@collection
class HealthLog {
  Id id = Isar.autoIncrement;

  // Quantitative 1-10 metrics for graphs and trends
  late int painLevel;
  late int moodLevel;

  // Qualitative Large String mapped to the AI analysis layer
  late String aiJournalEntry;

  @Index(type: IndexType.value)
  late DateTime timestamp;

  // Sync state for syncing later with Firebase.
  @Index(type: IndexType.value)
  bool isSynced = false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'painLevel': painLevel,
      'moodLevel': moodLevel,
      'aiJournalEntry': aiJournalEntry,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
