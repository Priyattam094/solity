import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

/// Local Authentication Service
///
/// Handles biometric and device credential authentication.
/// Used for app lock functionality.
class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if device supports biometrics or device credentials
  Future<bool> isBiometricAvailable() async {
    try {
      // Check if device supports any form of authentication
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      debugPrint('LocalAuth: isDeviceSupported = $isDeviceSupported');

      if (!isDeviceSupported) {
        return false;
      }

      // Check if biometrics can be checked
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      debugPrint('LocalAuth: canCheckBiometrics = $canCheckBiometrics');

      // Get available biometrics
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      debugPrint('LocalAuth: availableBiometrics = $availableBiometrics');

      return true;
    } on PlatformException catch (e) {
      debugPrint('LocalAuth: Error checking availability - ${e.message}');
      return false;
    }
  }

  /// Get list of available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint('LocalAuth: Error getting biometrics - ${e.message}');
      return [];
    }
  }

  /// Authenticate user with biometrics or device credentials
  Future<bool> authenticate({
    String reason = 'Please authenticate to access Solity',
  }) async {
    try {
      debugPrint('LocalAuth: Starting authentication...');

      final result = await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
          sensitiveTransaction: false,
        ),
      );

      debugPrint('LocalAuth: Authentication result = $result');
      return result;
    } on PlatformException catch (e) {
      debugPrint('LocalAuth: Authentication error - ${e.code}: ${e.message}');

      if (e.code == auth_error.notAvailable) {
        debugPrint('LocalAuth: Biometrics not available');
      } else if (e.code == auth_error.notEnrolled) {
        debugPrint('LocalAuth: No biometrics enrolled');
      } else if (e.code == auth_error.lockedOut) {
        debugPrint('LocalAuth: Too many attempts, locked out');
      } else if (e.code == auth_error.permanentlyLockedOut) {
        debugPrint('LocalAuth: Permanently locked out');
      } else if (e.code == auth_error.passcodeNotSet) {
        debugPrint('LocalAuth: Passcode not set');
      }

      return false;
    } catch (e) {
      debugPrint('LocalAuth: Unexpected error - $e');
      return false;
    }
  }

  /// Cancel ongoing authentication
  Future<void> cancelAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } catch (e) {
      debugPrint('LocalAuth: Error canceling authentication - $e');
    }
  }
}

