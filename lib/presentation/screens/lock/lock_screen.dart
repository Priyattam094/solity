import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../services/local_auth_service.dart';

/// Lock Screen
///
/// Shown when app lock is enabled and user needs to authenticate.
/// Calm, minimal design - not intimidating.
class LockScreen extends ConsumerStatefulWidget {
  final VoidCallback onUnlocked;

  const LockScreen({
    super.key,
    required this.onUnlocked,
  });

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  bool _isAuthenticating = false;
  String? _errorMessage;
  final LocalAuthService _authService = LocalAuthService();

  @override
  void initState() {
    super.initState();
    // Auto-trigger authentication after a short delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted && !_isAuthenticating) {
        _authenticate();
      }
    });
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
    });

    try {
      debugPrint('LockScreen: Starting authentication...');

      final success = await _authService.authenticate(
        reason: 'Unlock Solity',
      );

      debugPrint('LockScreen: Auth result = $success');

      if (mounted) {
        if (success) {
          widget.onUnlocked();
        } else {
          setState(() {
            _isAuthenticating = false;
            _errorMessage = 'Authentication cancelled';
          });
        }
      }
    } catch (e) {
      debugPrint('LockScreen: Auth error = $e');
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
          _errorMessage = 'Authentication error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppDimensions.pagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lock icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    _isAuthenticating
                        ? Icons.fingerprint_rounded
                        : Icons.lock_outline_rounded,
                    size: 50,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingXl),

                // Title
                Text(
                  'Solity',
                  style: AppTypography.displayMedium(
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingXs),

                Text(
                  'Your Digital Diary',
                  style: AppTypography.bodyMedium(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingXxl),

                // Status text
                if (_isAuthenticating)
                  Text(
                    'Authenticating...',
                    style: AppTypography.bodyMedium(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  )
                else if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingMd,
                      vertical: AppDimensions.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: AppTypography.bodySmall(
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingLg),
                ],

                // Unlock button
                if (!_isAuthenticating)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _authenticate,
                      icon: const Icon(Icons.fingerprint_rounded),
                      label: const Text('Unlock'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.spacingMd,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
