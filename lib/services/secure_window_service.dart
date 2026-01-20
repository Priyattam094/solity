import 'package:flutter/services.dart';

/// Secure Window Service
///
/// Handles platform-specific secure window flags.
/// Used for hiding app content in recent apps.
class SecureWindowService {
  static const MethodChannel _channel = MethodChannel('com.aestyr.aestyr/secure');

  /// Enable or disable secure mode (FLAG_SECURE on Android)
  /// When enabled, app content is hidden in recent apps and screenshots are blocked
  static Future<void> setSecure(bool secure) async {
    try {
      await _channel.invokeMethod('setSecure', secure);
    } on PlatformException {
      // Silently fail if platform doesn't support this
    }
  }
}

