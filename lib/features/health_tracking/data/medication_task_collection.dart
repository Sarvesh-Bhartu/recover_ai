import 'package:isar/isar.dart';

part 'medication_task_collection.g.dart'; // Isar Generator dependency

@collection
class MedicationTask {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String medicationName;

  late String dosage;

  @Index(type: IndexType.value)
  late DateTime scheduledTime;

  bool isTaken = false;

  // Sync state for syncing later with Firebase.
  @Index(type: IndexType.value)
  bool isSynced = false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicationName': medicationName,
      'dosage': dosage,
      'scheduledTime': scheduledTime.toIso8601String(),
      'isTaken': isTaken,
      // We don't push 'isSynced' itself to Firebase, as it's purely a local tracking flag.
    };
  }
}
