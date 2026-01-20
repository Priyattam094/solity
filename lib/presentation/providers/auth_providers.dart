import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/local_auth_service.dart';

/// Provider for LocalAuthService
final localAuthServiceProvider = Provider<LocalAuthService>((ref) {
  return LocalAuthService();
});

/// Provider for checking if biometrics are available
final biometricAvailableProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(localAuthServiceProvider);
  return authService.isBiometricAvailable();
});

/// State for app lock authentication
enum AuthState {
  initial,
  locked,
  unlocked,
  authenticating,
}

/// Notifier for managing app lock state
class AuthNotifier extends StateNotifier<AuthState> {
  final LocalAuthService _authService;

  AuthNotifier(this._authService) : super(AuthState.initial);

  /// Lock the app
  void lock() {
    state = AuthState.locked;
  }

  /// Attempt to unlock the app
  Future<bool> unlock() async {
    state = AuthState.authenticating;

    final success = await _authService.authenticate(
      reason: 'Authenticate to access your diary',
    );

    if (success) {
      state = AuthState.unlocked;
    } else {
      state = AuthState.locked;
    }

    return success;
  }

  /// Set initial state based on settings
  void initialize({required bool appLockEnabled}) {
    if (appLockEnabled) {
      state = AuthState.locked;
    } else {
      state = AuthState.unlocked;
    }
  }
}

/// Provider for AuthNotifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(localAuthServiceProvider);
  return AuthNotifier(authService);
});

