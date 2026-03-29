import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/user/data/user_repository.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/dashboard/presentation/main_navigation_shell.dart';
import '../../features/copilot/presentation/copilot_chat_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final userProfile = ref.watch(currentUserProfileProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (authState.isLoading || userProfile.isLoading) return null;
      
      final isAuth = authState.value != null;
      final isLoggingIn = state.matchedLocation == '/login';
      
      if (!isAuth) {
        return isLoggingIn ? null : '/login';
      }
      
      final isComplete = userProfile.value?.onboardingCompleted ?? false;
      final isSetup = state.matchedLocation == '/onboarding';
      
      if (isAuth && !isComplete) {
         return isSetup ? null : '/onboarding';
      }
      
      if (isLoggingIn || isSetup) {
        return '/';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/plan',
                builder: (context, state) => const Scaffold(body: Center(child: Text('Recovery Plan Placeholder'))),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/copilot',
                builder: (context, state) => const CopilotChatScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const Scaffold(body: Center(child: Text('Profile Placeholder'))),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
