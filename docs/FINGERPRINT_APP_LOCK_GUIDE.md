# 🔐 Fingerprint App Lock Implementation Guide

> A comprehensive guide for implementing biometric authentication (fingerprint/face unlock) in Flutter apps.  
> Avoid common mistakes and follow best practices.

---

## 📋 Table of Contents

1. [Required Dependencies](#required-dependencies)
2. [Android Setup](#android-setup)
3. [iOS Setup](#ios-setup)
4. [Implementation Code](#implementation-code)
5. [Do's and Don'ts](#dos-and-donts)
6. [Common Errors & Solutions](#common-errors--solutions)
7. [Testing Checklist](#testing-checklist)

---

## 📦 Required Dependencies

### pubspec.yaml

```yaml
dependencies:
  local_auth: ^2.3.0
  flutter_secure_storage: ^9.2.2  # For storing app lock preference
```

Run:
```bash
flutter pub get
```

---

## 🤖 Android Setup

### ✅ DO: Add Required Permissions

**File:** `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Biometric Permissions - ADD THESE BEFORE <application> tag -->
    <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
    <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
    
    <application
        ...
    </application>
</manifest>
```

### ✅ DO: Create/Verify MainActivity.kt

**File:** `android/app/src/main/kotlin/com/yourcompany/yourapp/MainActivity.kt`

```kotlin
package com.yourcompany.yourapp

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity()
```

> ⚠️ **CRITICAL:** Must extend `FlutterFragmentActivity`, NOT `FlutterActivity`!
> 
> The `local_auth` plugin requires `FragmentActivity` for the biometric dialog to work.

### ✅ DO: Check Build Configuration

**File:** `android/app/build.gradle.kts`

Ensure minimum SDK is at least 21:
```kotlin
android {
    defaultConfig {
        minSdk = 21  // Minimum for biometrics
        // OR
        minSdk = flutter.minSdkVersion  // If using Flutter's default
    }
}
```

### ❌ DON'T: Use FlutterActivity

```kotlin
// ❌ WRONG - This will NOT work with local_auth
class MainActivity: FlutterActivity()

// ✅ CORRECT - Use FragmentActivity
class MainActivity: FlutterFragmentActivity()
```

---

## 🍎 iOS Setup

### ✅ DO: Add Permission in Info.plist

**File:** `ios/Runner/Info.plist`

```xml
<dict>
    <!-- Add this key-value pair -->
    <key>NSFaceIDUsageDescription</key>
    <string>We need to verify your identity to protect your private entries.</string>
</dict>
```

### ✅ DO: Keep the reason user-friendly

Good examples:
- "Authenticate to access your private diary"
- "Verify your identity to unlock Solity"
- "Protect your entries with Face ID"

Bad examples:
- "For security" (too vague)
- "Required" (doesn't explain why)

---

## 💻 Implementation Code

### LocalAuthService (Complete Implementation)

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

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

      // Return true if device is supported (will fall back to PIN/Pattern)
      return true;
    } on PlatformException catch (e) {
      debugPrint('LocalAuth: Error checking availability - ${e.message}');
      return false;
    }
  }

  /// Authenticate user
  Future<bool> authenticate({
    String reason = 'Please authenticate to continue',
  }) async {
    try {
      debugPrint('LocalAuth: Starting authentication...');

      final result = await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,         // Keep auth dialog if app goes to background
          biometricOnly: false,     // Allow PIN/Pattern as fallback
          useErrorDialogs: true,    // Show system error dialogs
          sensitiveTransaction: false,
        ),
      );

      debugPrint('LocalAuth: Authentication result = $result');
      return result;
    } on PlatformException catch (e) {
      debugPrint('LocalAuth: Error - ${e.code}: ${e.message}');
      _handleAuthError(e);
      return false;
    } catch (e) {
      debugPrint('LocalAuth: Unexpected error - $e');
      return false;
    }
  }

  void _handleAuthError(PlatformException e) {
    switch (e.code) {
      case auth_error.notAvailable:
        debugPrint('LocalAuth: Biometrics not available');
        break;
      case auth_error.notEnrolled:
        debugPrint('LocalAuth: No biometrics enrolled');
        break;
      case auth_error.lockedOut:
        debugPrint('LocalAuth: Too many attempts, temporarily locked');
        break;
      case auth_error.permanentlyLockedOut:
        debugPrint('LocalAuth: Permanently locked out');
        break;
      case auth_error.passcodeNotSet:
        debugPrint('LocalAuth: Device passcode not set');
        break;
    }
  }

  /// Cancel ongoing authentication
  Future<void> cancelAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } catch (e) {
      debugPrint('LocalAuth: Error canceling - $e');
    }
  }
}
```

### Enabling App Lock (Provider Example)

```dart
Future<void> setAppLockEnabled(bool enabled) async {
  if (enabled) {
    // First check if biometrics are available
    final isAvailable = await _localAuthService.isBiometricAvailable();
    if (!isAvailable) {
      throw Exception('Biometrics not available on this device');
    }
    
    // Then authenticate to confirm
    final authenticated = await _localAuthService.authenticate(
      reason: 'Authenticate to enable app lock',
    );
    
    if (!authenticated) {
      throw Exception('Authentication failed');
    }
  }
  
  // Save preference
  await _secureStorage.write(key: 'app_lock_enabled', value: enabled.toString());
  state = state.copyWith(isAppLockEnabled: enabled);
}
```

### Lock Screen Implementation

```dart
class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthService _authService = LocalAuthService();
  bool _isAuthenticating = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Auto-trigger authentication when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticate();
    });
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    
    setState(() {
      _isAuthenticating = true;
      _errorMessage = '';
    });

    try {
      final success = await _authService.authenticate(
        reason: 'Authenticate to access Solity',
      );

      if (success) {
        // Navigate to home or pop lock screen
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        setState(() {
          _errorMessage = 'Authentication failed. Tap to try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _authenticate,  // Tap anywhere to retry
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 64),
              SizedBox(height: 24),
              Text('Solity is Locked'),
              if (_errorMessage.isNotEmpty) ...[
                SizedBox(height: 16),
                Text(_errorMessage, style: TextStyle(color: Colors.red)),
                SizedBox(height: 8),
                Text('Tap anywhere to try again'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## ✅ Do's and Don'ts

### ✅ DO

| Action | Reason |
|--------|--------|
| Use `FlutterFragmentActivity` on Android | Required for biometric dialog |
| Set `biometricOnly: false` | Allows PIN/Pattern fallback |
| Set `stickyAuth: true` | Keeps dialog when app backgrounds |
| Set `useErrorDialogs: true` | Shows native error messages |
| Add both biometric permissions on Android | Compatibility with older devices |
| Auto-trigger auth on lock screen load | Better UX - no need for user tap |
| Provide tap-to-retry on failure | User can easily retry |
| Store lock preference in secure storage | Persists across app restarts |
| Check availability before enabling | Prevents enabling on unsupported devices |
| Authenticate before enabling | Confirms user identity |

### ❌ DON'T

| Action | Reason |
|--------|--------|
| Use `FlutterActivity` | Biometric dialog won't appear |
| Set `biometricOnly: true` | Excludes PIN/Pattern users |
| Forget permissions in AndroidManifest | Auth will silently fail |
| Forget NSFaceIDUsageDescription on iOS | App will crash on Face ID |
| Skip availability check | May enable on unsupported devices |
| Skip authentication when enabling | Anyone could enable/disable |
| Use synchronous/blocking UI | Auth is async, UI should reflect state |
| Ignore `PlatformException` | Miss important error info |
| Forget to handle locked out state | Users get confused |

---

## ⚠️ Common Errors & Solutions

### Error 1: `ClassNotFoundException: MainActivity`

**Cause:** Missing or incorrectly named MainActivity.kt

**Solution:**
1. Verify file exists at: `android/app/src/main/kotlin/[package]/MainActivity.kt`
2. Ensure package name matches your app's package
3. Ensure class extends `FlutterFragmentActivity`
4. Run `flutter clean && flutter pub get`

### Error 2: Authentication dialog doesn't appear

**Cause:** Using `FlutterActivity` instead of `FlutterFragmentActivity`

**Solution:**
```kotlin
// Change this:
class MainActivity: FlutterActivity()

// To this:
class MainActivity: FlutterFragmentActivity()
```

### Error 3: "Biometrics not available" on supported device

**Cause:** User hasn't enrolled fingerprint/face

**Solution:** Show message directing user to device settings
```dart
if (!isAvailable) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Setup Required'),
      content: Text('Please enroll a fingerprint in your device settings first.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
    ),
  );
}
```

### Error 4: "PermanentlyLockedOut"

**Cause:** Too many failed attempts

**Solution:** Direct user to device settings to reset
```dart
if (e.code == auth_error.permanentlyLockedOut) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Locked Out'),
      content: Text('Too many failed attempts. Please unlock your device using PIN/Pattern first.'),
    ),
  );
}
```

### Error 5: App crashes on iOS without error

**Cause:** Missing `NSFaceIDUsageDescription`

**Solution:** Add to `ios/Runner/Info.plist`:
```xml
<key>NSFaceIDUsageDescription</key>
<string>Authenticate to access your private entries.</string>
```

---

## 🧪 Testing Checklist

### Before Release

- [ ] Test on device with fingerprint enrolled
- [ ] Test on device with face unlock enrolled
- [ ] Test on device with only PIN/Pattern (no biometrics)
- [ ] Test on device with NO security set up
- [ ] Test enabling app lock
- [ ] Test disabling app lock
- [ ] Test app lock after app restart
- [ ] Test app lock after device restart
- [ ] Test auth failure (wrong fingerprint)
- [ ] Test auth cancellation (back button)
- [ ] Test temporary lockout (multiple failures)
- [ ] Test permanent lockout scenario
- [ ] Test on Android emulator with fingerprint simulation
- [ ] Test on iOS simulator with Face ID simulation

### Debug Commands

**Android Emulator - Simulate Fingerprint:**
```bash
adb -e emu finger touch 1
```

**iOS Simulator - Simulate Face ID:**
- Hardware > Face ID > Enrolled
- Hardware > Face ID > Matching Face / Non-matching Face

---

## 📁 File Structure Reference

```
android/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── AndroidManifest.xml  ← Add permissions here
│   │       └── kotlin/
│   │           └── com/yourcompany/yourapp/
│   │               └── MainActivity.kt  ← FlutterFragmentActivity
│   └── build.gradle.kts  ← Check minSdk
│
ios/
├── Runner/
│   └── Info.plist  ← Add NSFaceIDUsageDescription

lib/
├── services/
│   └── local_auth_service.dart  ← Authentication logic
├── presentation/
│   ├── screens/
│   │   └── lock_screen.dart  ← Lock UI
│   └── providers/
│       └── settings_provider.dart  ← Manage app lock state
```

---

## 🔗 References

- [local_auth Package](https://pub.dev/packages/local_auth)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [Android Biometric Docs](https://developer.android.com/training/sign-in/biometric-auth)
- [iOS LocalAuthentication](https://developer.apple.com/documentation/localauthentication)

---

*Last Updated: December 2024*
*Tested with Flutter 3.x and local_auth 2.3.0*

