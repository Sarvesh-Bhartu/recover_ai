import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recover_ai/core/theme/app_theme.dart';
import 'package:recover_ai/core/widgets/progress_ring.dart';
import 'package:recover_ai/core/widgets/medication_card.dart';
import 'package:recover_ai/features/user/data/user_repository.dart';
import 'package:recover_ai/features/health_tracking/data/local_health_repository.dart';
import 'package:recover_ai/features/health_tracking/data/medication_task_collection.dart';
import 'package:recover_ai/features/health_tracking/data/daily_health_log_collection.dart';
import 'package:recover_ai/features/health_tracking/data/sync_repository.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _getGreeting() {
    final hour = TimeOfDay.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  String _formatTime(DateTime time) {
    int hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $period';
  }

  void _showAddMedicationDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final doseCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Add Medication'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Medication Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: doseCtrl,
              decoration: const InputDecoration(labelText: 'Dosage (e.g. 500mg)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                final task = MedicationTask()
                  ..medicationName = nameCtrl.text.trim()
                  ..dosage = doseCtrl.text.trim()
                  ..scheduledTime = DateTime.now().add(const Duration(minutes: 60))
                  ..isTaken = false;
                
                ref.read(localHealthRepositoryProvider).addMedicationTask(task);
                Navigator.pop(context);
              }
            },
            child: const Text('Save Task'),
          )
        ],
      ),
    );
  }

  void _showHealthLoggerDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        double pain = 1;
        double mood = 5;
        final journalCtrl = TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppTheme.surfaceColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: const Text('Morning Check-in'),
              content: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pain Level: ${pain.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Slider(
                        value: pain,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        activeColor: AppTheme.dangerColor,
                        onChanged: (val) => setState(() => pain = val),
                      ),
                      const SizedBox(height: 16),
                      Text('Mood Level: ${mood.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Slider(
                        value: mood,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) => setState(() => mood = val),
                      ),
                      const SizedBox(height: 24),
                      const Text('Journal Entry', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: journalCtrl,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'How are you feeling today?',
                          hintStyle: const TextStyle(color: Colors.white24),
                          filled: true,
                          fillColor: AppTheme.backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
                ),
                ElevatedButton(
                  onPressed: () {
                    final log = HealthLog()
                      ..painLevel = pain.toInt()
                      ..moodLevel = mood.toInt()
                      ..aiJournalEntry = journalCtrl.text.trim()
                      ..timestamp = DateTime.now()
                      ..isSynced = false;
                      
                    ref.read(localHealthRepositoryProvider).addHealthLog(log);
                    Navigator.pop(context);
                  },
                  child: const Text('Save Log'),
                )
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(currentUserProfileProvider).value;
    final medicationsAsync = ref.watch(todaysMedicationsProvider);
    
    // Connects Riverpod lifecycle to the Background Sync Engine
    ref.watch(backgroundSyncProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMedicationDialog(context, ref),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.backgroundColor,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Med', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
                      ),
                      Text(
                        userProfile?.name?.split(' ').first ?? 'User',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.cloud_done_rounded, color: AppTheme.primaryColor, size: 20),
                      const SizedBox(width: 12),
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: AppTheme.surfaceColor,
                        child: Icon(Icons.person_rounded, color: AppTheme.textSecondary, size: 28),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              
              const Center(child: ProgressRing(progress: 0.72)),
              const SizedBox(height: 40),
              
              Text('Your Medications', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              medicationsAsync.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.health_and_safety_outlined, color: AppTheme.textSecondary, size: 48),
                          SizedBox(height: 12),
                          Text(
                            'No medications scheduled.\nTap the + button to build your routine.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return Column(
                    children: tasks.map((t) {
                      return MedicationCard(
                        medicationName: t.medicationName,
                        dosage: t.dosage,
                        time: _formatTime(t.scheduledTime),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err', style: const TextStyle(color: AppTheme.dangerColor)),
              ),
              
              const SizedBox(height: 32),
              
              // Timeline View
              Text('Today\'s Timeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => _showHealthLoggerDialog(context, ref),
                      leading: const Icon(Icons.edit_note_rounded, color: AppTheme.primaryColor),
                      title: const Text('Log Morning Check-in'),
                      subtitle: const Text('Tap to open Daily Survey', style: TextStyle(color: AppTheme.primaryColor)),
                      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white24),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
