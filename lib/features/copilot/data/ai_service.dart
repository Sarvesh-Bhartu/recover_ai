import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:recover_ai/features/health_tracking/data/local_health_repository.dart';
import 'package:recover_ai/features/health_tracking/data/daily_health_log_collection.dart';

final copilotServiceProvider = Provider<CopilotService>((ref) {
  final isar = ref.watch(isarProvider);
  return CopilotService(isar: isar);
});

class CopilotService {
  final Isar _isar;
  late GenerativeModel _model;
  late ChatSession chatSession;
  bool isInitialized = false;

  CopilotService({required Isar isar}) : _isar = isar;

  /// Safely injects the Offline Isar Database natively into the AI's core Brain.
  Future<void> initializeWithIsarContext() async {
    // 1. Fetch the last 7 offline health logs
    final logs = await _isar.healthLogs.where().sortByTimestampDesc().limit(7).findAll();
    
    // 2. Synthesize the logs into unstructured text for the AI
    String dynamicContext = '';
    if (logs.isEmpty) {
      dynamicContext = "No history logged yet. Kindly encourage them to use the Dashboard Timeline Check-in button so you have data to analyze!";
    } else {
      for (var log in logs) {
        dynamicContext += "Date logged: ${log.timestamp}\n";
        dynamicContext += "Pain Score: ${log.painLevel}/10\n";
        dynamicContext += "Mood Score: ${log.moodLevel}/10\n";
        dynamicContext += "User Journal: ${log.aiJournalEntry}\n\n";
      }
    }

    // 3. Assemble the intelligence Model
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API Key missing in .env file!');
    }

    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system('''
You are the official Recover AI Health Copilot.
Personality: You are a friendly, casual, highly empathetic coach and health assistant. You speak directly to the user as a supportive friend. Do not be overly clinical unless stating facts. Use emojis occasionally. Keep responses beautifully concise. Do not write monolithic essays.

Context: I will securely feed you the user's latest Health Logs consisting of their daily Pain (1-10), Mood (1-10), and their personal journal entry. 
Your Core Directive: Explicitly explicitly reference the user's exact logs below to formulate a hyper-personalized response. If their pain is high, show deep empathy. If their mood is up, be hyper-enthusiastic. 

---
User's Recent Logs (Last 7 Days):
$dynamicContext
'''),
    );

    // Start a clean, context-injected chat session
    chatSession = _model.startChat();
    isInitialized = true;
  }
}
