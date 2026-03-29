import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'medication_task_collection.dart';
import 'daily_health_log_collection.dart';

final isarProvider = Provider<Isar>((ref) => throw UnimplementedError('Initialized in main'));

final localHealthRepositoryProvider = Provider<LocalHealthRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return LocalHealthRepository(isar);
});

final todaysMedicationsProvider = StreamProvider<List<MedicationTask>>((ref) {
  final repo = ref.watch(localHealthRepositoryProvider);
  return repo.watchTodaysMedications();
});

class LocalHealthRepository {
  final Isar isar;

  LocalHealthRepository(this.isar);

  Future<void> addMedicationTask(MedicationTask task) async {
    await isar.writeTxn(() async {
      await isar.medicationTasks.put(task);
    });
  }

  Stream<List<MedicationTask>> watchTodaysMedications() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return isar.medicationTasks
        .filter()
        .scheduledTimeBetween(startOfDay, endOfDay)
        .sortByScheduledTime()
        .watch(fireImmediately: true);
  }

  Future<void> toggleMedicationTaken(int id, bool isTaken) async {
    final task = await isar.medicationTasks.get(id);
    if (task != null) {
      await isar.writeTxn(() async {
        task.isTaken = isTaken;
        task.isSynced = false;
        await isar.medicationTasks.put(task);
      });
    }
  }

  Future<void> addHealthLog(HealthLog log) async {
    await isar.writeTxn(() async {
      await isar.healthLogs.put(log);
    });
  }
}
