import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes.dart';
import '../presentation/providers/settings_providers.dart';
import '../presentation/providers/auth_providers.dart';
import '../presentation/screens/lock/lock_screen.dart';
import '../services/secure_window_service.dart';

/// Solity App Root
///
/// Private. Offline. No Account.
/// Your inner world stays on your device.
class SolityApp extends ConsumerStatefulWidget {
  const SolityApp({super.key});

  @override
  ConsumerState<SolityApp> createState() => _SolityAppState();
}

class _SolityAppState extends ConsumerState<SolityApp> with WidgetsBindingObserver {
  bool _isLocked = false;
  bool _initialized = false;
  bool? _lastSecureMode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final settings = ref.read(settingsNotifierProvider);

    // Lock app when it goes to background (if app lock is enabled)
    if (state == AppLifecycleState.paused && settings.appLockEnabled) {
      setState(() {
        _isLocked = true;
      });
    }
  }

  void _initializeLockState() {
    if (!_initialized) {
      final settings = ref.read(settingsNotifierProvider);
      _isLocked = settings.appLockEnabled;
      _initialized = true;
    }
  }

  /// Update secure mode for hiding app in recent apps
  void _updateSecureMode(bool hidePreview) {
    // Only update if the value changed
    if (_lastSecureMode != hidePreview) {
      _lastSecureMode = hidePreview;
      SecureWindowService.setSecure(hidePreview);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeDataProvider);
    final settings = ref.watch(settingsNotifierProvider);

    // Initialize lock state on first build
    _initializeLockState();

    // Update secure mode when setting changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSecureMode(settings.hidePreviewInRecents);
    });

    return MaterialApp.router(
      title: 'Solity',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: AppRoutes.router,
      builder: (context, child) {
        // Apply font size scaling
        final mediaQuery = MediaQuery.of(context);
        final scaledMediaQuery = mediaQuery.copyWith(
          textScaler: TextScaler.linear(settings.fontSize),
        );

        // Show lock screen if app is locked and app lock is enabled
        if (_isLocked && settings.appLockEnabled) {
          return MediaQuery(
            data: scaledMediaQuery,
            child: LockScreen(
              onUnlocked: () {
                setState(() {
                  _isLocked = false;
                });
              },
            ),
          );
        }

        return MediaQuery(
          data: scaledMediaQuery,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

