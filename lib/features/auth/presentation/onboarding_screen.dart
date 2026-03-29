import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../user/data/user_repository.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  void _finishOnboarding() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    
    setState(() => _isLoading = true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    
    try {
      if (uid != null) {
        await ref.read(userRepositoryProvider).updateUser(uid, {
          'name': name,
          'onboarding_completed': true,
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('What should we call you?'),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const Spacer(),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _finishOnboarding,
                child: const Text('Complete Setup'),
              )
          ],
        ),
      ),
    );
  }
}
