import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:recover_ai/features/health_tracking/data/local_health_repository.dart';
import 'package:recover_ai/features/user/data/user_repository.dart';
import 'medication_task_collection.dart';
import 'daily_health_log_collection.dart';

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  final isar = ref.watch(isarProvider);
  final userProfileAsync = ref.watch(currentUserProfileProvider);
  
  return SyncRepository(
    isar: isar,
    firestore: FirebaseFirestore.instance,
    userId: userProfileAsync.value?.uid,
  );
});

final backgroundSyncProvider = Provider<void>((ref) {
  final syncRepo = ref.watch(syncRepositoryProvider);
  
  // Fire an immediate sync when the provider mounts
  syncRepo.pushDirtyRecords();

  // Then fire a periodic sync every 5 minutes to sweep any offline tasks created while the app was running
  final timer = Timer.periodic(const Duration(minutes: 5), (_) {
    syncRepo.pushDirtyRecords();
  });

  // Cleanup to prevent memory leaks if the user logs out
  ref.onDispose(() => timer.cancel());
});

class SyncRepository {
  final Isar isar;
  final FirebaseFirestore firestore;
  final String? userId;

  SyncRepository({
    required this.isar,
    required this.firestore,
    required this.userId,
  });

  Future<void> pushDirtyRecords() async {
    if (userId == null) return; 

    // 1. Sync Medication Tasks
    final dirtyTasks = await isar.medicationTasks.filter().isSyncedEqualTo(false).findAll();
    
    for (var task in dirtyTasks) {
      try {
        await firestore
            .collection('users')
            .doc(userId)
            .collection('medications')
            .doc(task.id.toString())
            .set(task.toMap(), SetOptions(merge: true));

        // Mark as synced locally
        await isar.writeTxn(() async {
          task.isSynced = true;
          await isar.medicationTasks.put(task);
        });
      } catch (e) {
        // Silently swallow network errors; they will simply be reattempted on the next loop
      }
    }

    // 2. Sync Health Logs
    final dirtyLogs = await isar.healthLogs.filter().isSyncedEqualTo(false).findAll();
    
    for (var log in dirtyLogs) {
      try {
        await firestore
            .collection('users')
            .doc(userId)
            .collection('healthLogs')
            .doc(log.id.toString())
            .set(log.toMap(), SetOptions(merge: true));

        await isar.writeTxn(() async {
          log.isSynced = true;
          await isar.healthLogs.put(log);
        });
      } catch (e) {
        // Silently swallow network errors
      }
    }
  }
}
