import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../providers/diary_providers.dart';

/// Home Screen - "Today"
///
/// Ground the user in today, not the app.
/// No pressure. No "you missed a day". Gentle invitation.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastEntryAsync = ref.watch(lastEntryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spacingXl),

              // Today's date - soft, small
              Text(
                DateFormatter.fullDate(DateTime.now()),
                style: AppTypography.dateDisplay(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),

              const Spacer(),

              // Center content
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Invitation text
                    Text(
                      "What's on your mind today?",
                      style: AppTypography.prompt(
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppDimensions.spacingXxl),

                    // Write button - primary action
                    _WriteButton(
                      onTap: () => context.push(AppRoutes.write),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Last entry preview (optional, blurred)
              lastEntryAsync.when(
                data: (lastEntry) {
                  if (lastEntry == null) return const SizedBox.shrink();
                  return _LastEntryPreview(
                    preview: lastEntry.preview,
                    date: DateFormatter.relative(lastEntry.createdAt),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppDimensions.spacingLg),
            ],
          ),
        ),
      ),
    );
  }
}

/// Write Button
///
/// Large tap area, soft shadow, inviting.
class _WriteButton extends StatefulWidget {
  final VoidCallback onTap;

  const _WriteButton({required this.onTap});

  @override
  State<_WriteButton> createState() => _WriteButtonState();
}

class _WriteButtonState extends State<_WriteButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: AppDimensions.animationFast,
        transform: Matrix4.identity()..scale(_isPressed ? 0.96 : 1.0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingXxl,
          vertical: AppDimensions.spacingLg,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          boxShadow: _isPressed ? AppDimensions.shadowSoft : AppDimensions.shadowMedium,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit_rounded,
              color: theme.colorScheme.onPrimary,
              size: AppDimensions.iconSizeMd,
            ),
            const SizedBox(width: AppDimensions.spacingSm),
            Text(
              'Write',
              style: AppTypography.titleLarge(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Last Entry Preview
///
/// Small preview of the last entry, subtle.
class _LastEntryPreview extends StatelessWidget {
  final String preview;
  final String date;

  const _LastEntryPreview({
    required this.preview,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: AppDimensions.cardPadding,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        boxShadow: isDark ? null : AppDimensions.shadowSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history_rounded,
                size: AppDimensions.iconSizeSm,
                color: theme.textTheme.bodySmall?.color,
              ),
              const SizedBox(width: AppDimensions.spacingXs),
              Text(
                'Last entry',
                style: AppTypography.labelSmall(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: AppTypography.labelSmall(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingXs),
          Text(
            preview,
            style: AppTypography.entryPreview(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

