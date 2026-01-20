import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../app/routes.dart';

/// App Shell with Bottom Navigation
///
/// Minimal, touch-first navigation.
/// Feels like turning pages, not using software.
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == AppRoutes.home) return 0;
    if (location == AppRoutes.entries) return 1;
    if (location == AppRoutes.settings) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.bottomNavigationBarTheme.backgroundColor,
        boxShadow: isDark ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingMd,
            vertical: AppDimensions.spacingXs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Today',
                isSelected: currentIndex == 0,
                onTap: () => context.go(AppRoutes.home),
              ),
              _NavItem(
                icon: Icons.book_rounded,
                label: 'Entries',
                isSelected: currentIndex == 1,
                onTap: () => context.go(AppRoutes.entries),
              ),
              _NavItem(
                icon: Icons.settings_rounded,
                label: 'Settings',
                isSelected: currentIndex == 2,
                onTap: () => context.go(AppRoutes.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.bottomNavigationBarTheme.unselectedItemColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AppDimensions.animationFast,
              padding: const EdgeInsets.all(AppDimensions.spacingXs),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
              child: Icon(
                icon,
                color: color,
                size: AppDimensions.iconSizeMd,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingXxs),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

