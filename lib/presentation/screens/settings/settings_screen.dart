import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/diary_providers.dart';
import '../../providers/settings_providers.dart';
import '../../providers/auth_providers.dart';

/// Settings Screen - "Trust Center"
///
/// This screen builds TRUST, not features.
/// Privacy, Data, Appearance, About.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _toggleAppLock(BuildContext context, WidgetRef ref, bool value) async {
    if (value) {
      // Check if device supports authentication before enabling
      final authService = ref.read(localAuthServiceProvider);
      final isAvailable = await authService.isBiometricAvailable();

      if (!isAvailable) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Screen lock is not set up on this device. Please set up PIN, pattern, or biometrics in device settings.'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 4),
            ),
          );
        }
        return;
      }

      // Enable app lock - authentication will be required when opening the app
      ref.read(settingsNotifierProvider.notifier).setAppLockEnabled(true);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('App lock enabled. You will need to authenticate when opening the app.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      // Disabling app lock - require authentication first
      final authService = ref.read(localAuthServiceProvider);
      final success = await authService.authenticate(
        reason: 'Authenticate to disable app lock',
      );

      if (success) {
        ref.read(settingsNotifierProvider.notifier).setAppLockEnabled(false);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('App lock disabled.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication required to disable app lock.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: AppDimensions.pagePadding,
        children: [
          // Privacy Section
          _SectionHeader(title: 'Privacy'),
          _SettingsCard(
            children: [
              _SwitchTile(
                icon: Icons.lock_outline_rounded,
                title: 'App Lock',
                subtitle: 'Require authentication to open',
                value: settings.appLockEnabled,
                onChanged: (value) => _toggleAppLock(context, ref, value),
              ),
              const Divider(height: 1),
              _SwitchTile(
                icon: Icons.visibility_off_outlined,
                title: 'Hide in Recent Apps',
                subtitle: 'Hide preview when switching apps',
                value: settings.hidePreviewInRecents,
                onChanged: (value) {
                  ref.read(settingsNotifierProvider.notifier).setHidePreviewInRecents(value);
                },
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacingLg),

          // Data Section
          _SectionHeader(title: 'Data'),
          _SettingsCard(
            children: [
              _ActionTile(
                icon: Icons.download_outlined,
                title: 'Export as Text',
                subtitle: 'Save diary as readable text file',
                onTap: () => _exportAsText(context, ref),
              ),
              const Divider(height: 1),
              _ActionTile(
                icon: Icons.code_outlined,
                title: 'Export as JSON',
                subtitle: 'Backup for restore or transfer',
                onTap: () => _exportAsJson(context, ref),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacingLg),

          // Appearance Section
          _SectionHeader(title: 'Appearance'),
          _SettingsCard(
            children: [
              _ThemeSelector(
                currentTheme: settings.themeMode,
                onChanged: (mode) {
                  ref.read(settingsNotifierProvider.notifier).setThemeMode(mode);
                },
              ),
              const Divider(height: 1),
              _FontSizeSelector(
                currentSize: settings.fontSize,
                onChanged: (size) {
                  ref.read(settingsNotifierProvider.notifier).setFontSize(size);
                },
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacingLg),

          // About Section
          _SectionHeader(title: 'About'),
          _SettingsCard(
            children: [
              _InfoTile(
                icon: Icons.info_outline_rounded,
                title: 'Solity',
                subtitle: 'Version 1.0.0',
              ),
              const Divider(height: 1),
              _InfoTile(
                icon: Icons.business_outlined,
                title: 'By Aestyr',
                subtitle: 'Made with care',
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMd),
                child: Text(
                  'Solity is a private digital diary. Your data stays on your device. '
                  'No account required. No cloud. No tracking.',
                  style: AppTypography.bodySmall(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacingXxl),
        ],
      ),
    );
  }

  Future<void> _exportAsText(BuildContext context, WidgetRef ref) async {
    try {
      final content = await ref.read(diaryNotifierProvider.notifier).exportAsText();
      await _shareContent(context, content, 'solity_diary.txt');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Future<void> _exportAsJson(BuildContext context, WidgetRef ref) async {
    try {
      final content = await ref.read(diaryNotifierProvider.notifier).exportAsJson();
      await _shareContent(context, content, 'solity_backup.json');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Future<void> _shareContent(BuildContext context, String content, String filename) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsString(content);

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Solity Export',
    );
  }
}

/// Section Header
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.spacingXs,
        bottom: AppDimensions.spacingSm,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.labelSmall(
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
    );
  }
}

/// Settings Card Container
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: isDark ? null : AppDimensions.shadowSoft,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

/// Switch Tile
class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleSmall),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall(color: theme.textTheme.bodySmall?.color),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingXs,
      ),
    );
  }
}

/// Action Tile
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleSmall),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall(color: theme.textTheme.bodySmall?.color),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: theme.textTheme.bodySmall?.color,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingXs,
      ),
    );
  }
}

/// Info Tile
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleSmall),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall(color: theme.textTheme.bodySmall?.color),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingXs,
      ),
    );
  }
}

/// Theme Selector
class _ThemeSelector extends StatelessWidget {
  final SolityThemeMode currentTheme;
  final ValueChanged<SolityThemeMode> onChanged;

  const _ThemeSelector({
    required this.currentTheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: AppDimensions.spacingMd),
              Text('Theme', style: theme.textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          Row(
            children: SolityThemeMode.values.map((mode) {
              final isSelected = mode == currentTheme;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(mode),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: mode != SolityThemeMode.dim ? AppDimensions.spacingSm : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.dividerTheme.color ?? Colors.grey,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        mode.displayName,
                        style: AppTypography.labelMedium(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Font Size Selector
class _FontSizeSelector extends StatelessWidget {
  final double currentSize;
  final ValueChanged<double> onChanged;

  const _FontSizeSelector({
    required this.currentSize,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sizes = [0.85, 1.0, 1.15];
    final labels = ['Small', 'Normal', 'Large'];

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.text_fields_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: AppDimensions.spacingMd),
              Text('Font Size', style: theme.textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          Row(
            children: List.generate(sizes.length, (index) {
              final size = sizes[index];
              final isSelected = (currentSize - size).abs() < 0.01;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(size),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index < sizes.length - 1 ? AppDimensions.spacingSm : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.dividerTheme.color ?? Colors.grey,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        labels[index],
                        style: AppTypography.labelMedium(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
