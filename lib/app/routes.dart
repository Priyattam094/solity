import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/write/write_screen.dart';
import '../presentation/screens/entries/entries_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/shell/app_shell.dart';

/// App Routes
///
/// Simple navigation structure for Solity.
class AppRoutes {
  AppRoutes._();

  // Route names
  static const String home = '/';
  static const String write = '/write';
  static const String writeEdit = '/write/:id';
  static const String entries = '/entries';
  static const String settings = '/settings';

  /// Global navigator key
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  /// Router configuration
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    routes: [
      // Shell route for bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: entries,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EntriesScreen(),
            ),
          ),
          GoRoute(
            path: settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
      // Write screen (full screen, outside shell)
      GoRoute(
        path: write,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const WriteScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              ),
            );
          },
        ),
      ),
      // Edit entry (full screen, outside shell)
      GoRoute(
        path: writeEdit,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final entryId = state.pathParameters['id']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: WriteScreen(entryId: entryId),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}

