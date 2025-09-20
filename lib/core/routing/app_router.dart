import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/system_planning/presentation/system_planning_screen.dart';
import '../../features/layout_planning/presentation/layout_planning_screen.dart';
import '../../features/export_calculate/presentation/export_calculate_screen.dart';
import '../../shared/providers/auth_providers.dart';
import '../navigation/main_navigation.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/auth',
    redirect: (context, state) {
      return authState.when(
        data: (user) {
          final isAuthRoute = state.uri.path == '/auth';
          final isOnboardingRoute = state.uri.path == '/onboarding';
          
          if (user == null) {
            // User not authenticated
            if (!isAuthRoute) return '/auth';
            return null;
          } else {
            // User authenticated
            if (isAuthRoute) return '/system-planning';
            return null;
          }
        },
        loading: () => null, // Keep current route while loading
        error: (_, __) => '/auth', // Redirect to auth on error
      );
    },
    routes: [
      // Authentication Screen
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      
      // Onboarding Flow (for authenticated users)
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Main App with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: '/system-planning',
            name: 'system-planning',
            builder: (context, state) => const SystemPlanningScreen(),
          ),
          GoRoute(
            path: '/layout-planning',
            name: 'layout-planning',
            builder: (context, state) => const LayoutPlanningScreen(),
          ),
          GoRoute(
            path: '/export-calculate',
            name: 'export-calculate',
            builder: (context, state) => const ExportCalculateScreen(),
          ),
        ],
      ),
    ],
  );
});

// Route names for easy navigation
class AppRoutes {
  static const auth = '/auth';
  static const onboarding = '/onboarding';
  static const systemPlanning = '/system-planning';
  static const layoutPlanning = '/layout-planning';
  static const exportCalculate = '/export-calculate';
}