import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recover_ai/core/theme/app_theme.dart';
import 'package:recover_ai/features/copilot/data/ai_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CopilotChatScreen extends ConsumerStatefulWidget {
  const CopilotChatScreen({super.key});

  @override
  ConsumerState<CopilotChatScreen> createState() => _CopilotChatScreenState();
}

class _CopilotChatScreenState extends ConsumerState<CopilotChatScreen> {
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  bool _isLoading = true;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeBrain();
  }

  Future<void> _initializeBrain() async {
    final aiService = ref.read(copilotServiceProvider);
    if (!aiService.isInitialized) {
      await aiService.initializeWithIsarContext();
    }
    if (mounted) setState(() { _isLoading = false; });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;

    final aiService = ref.read(copilotServiceProvider);
    
    _msgCtrl.clear();
    setState(() { _isTyping = true; });
    _scrollToBottom();

    try {
      final response = await aiService.chatSession.sendMessage(Content.text(text));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() { _isTyping = false; });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppTheme.primaryColor),
              SizedBox(height: 16),
              Text('Analyzing your offline logs...', style: TextStyle(color: AppTheme.textSecondary)),
            ],
          ),
        ),
      );
    }

    final aiService = ref.watch(copilotServiceProvider);
    final history = aiService.chatSession.history.toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('AI Copilot', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final message = history[index];
                final isUser = message.role == 'user';
                final part = message.parts.isNotEmpty ? message.parts.first : null;
                final content = part is TextPart ? part.text : '';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? AppTheme.primaryColor.withOpacity(0.9) : AppTheme.surfaceColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isUser ? 20 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 20),
                      ),
                    ),
                    child: MarkdownBody(
                      data: content,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(color: isUser ? AppTheme.backgroundColor : Colors.white, fontSize: 16),
                        strong: TextStyle(color: isUser ? AppTheme.backgroundColor : AppTheme.primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Copilot is typing...', style: TextStyle(color: AppTheme.textSecondary, fontStyle: FontStyle.italic)),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgCtrl,
                    decoration: InputDecoration(
                      hintText: 'Ask your copilot anything...',
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true,
                      fillColor: AppTheme.backgroundColor,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppTheme.backgroundColor),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
