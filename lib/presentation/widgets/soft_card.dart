import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';

/// Soft Card Widget
///
/// Reusable card with soft shadows.
/// Feels like paper, not tiles.
class SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SoftCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget card = Container(
      margin: margin,
      padding: padding ?? AppDimensions.cardPadding,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: isDark ? null : AppDimensions.shadowSoft,
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}

/// Elevated Soft Card
///
/// Card with more prominent shadow for important content.
class ElevatedSoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const ElevatedSoftCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget card = Container(
      margin: margin,
      padding: padding ?? AppDimensions.cardPadding,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: isDark ? null : AppDimensions.shadowMedium,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}

