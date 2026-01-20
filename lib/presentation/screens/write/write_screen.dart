import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../providers/diary_providers.dart';

/// Write Screen - "Inner Space"
///
/// This is the HEART of Solity.
/// Full-screen writing. No toolbar initially.
/// "I can write freely. No one's watching."
class WriteScreen extends ConsumerStatefulWidget {
  final String? entryId;

  const WriteScreen({
    super.key,
    this.entryId,
  });

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  late TextEditingController _controller;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _hasChanges = false;
  String? _originalContent;

  bool get isEditing => widget.entryId != null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadContent();
  }

  Future<void> _loadContent() async {
    if (isEditing) {
      final entry = await ref.read(diaryRepositoryProvider).getEntry(widget.entryId!);
      if (entry != null && mounted) {
        _controller.text = entry.content;
        _originalContent = entry.content;
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasChanges = _controller.text != (_originalContent ?? '');
    if (hasChanges != _hasChanges) {
      setState(() => _hasChanges = hasChanges);
    }
  }

  Future<void> _saveAndExit() async {
    final content = _controller.text.trim();

    // Don't save empty entries
    if (content.isEmpty) {
      if (mounted) context.pop();
      return;
    }

    // Don't save if no changes
    if (!_hasChanges && isEditing) {
      if (mounted) context.pop();
      return;
    }

    setState(() => _isSaving = true);

    try {
      final notifier = ref.read(diaryNotifierProvider.notifier);
      if (isEditing) {
        await notifier.updateEntry(widget.entryId!, content);
      } else {
        await notifier.createEntry(content);
      }
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() => _isSaving = false);
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (_hasChanges && _controller.text.trim().isNotEmpty) {
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Save changes?'),
          content: const Text('You have unsaved changes.'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Discard'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      if (shouldSave == true) {
        await _saveAndExit();
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final canPop = await _onWillPop();
        if (canPop && mounted) {
          context.pop();
        }
      },
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          // Swipe down to save & exit
          if (details.primaryVelocity != null && details.primaryVelocity! > 300) {
            _saveAndExit();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Top bar with date and actions
                _TopBar(
                  date: DateFormatter.writingDate(DateTime.now()),
                  isSaving: _isSaving,
                  hasChanges: _hasChanges,
                  onClose: () async {
                    final canPop = await _onWillPop();
                    if (canPop && mounted) {
                      context.pop();
                    }
                  },
                  onSave: _saveAndExit,
                ),

                // Writing area
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: AppDimensions.writingPadding,
                          child: TextField(
                            controller: _controller,
                            onChanged: (_) => _onTextChanged(),
                            autofocus: !isEditing,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.8,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Start writing...',
                              hintStyle: AppTypography.bodyLarge(
                                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: false,
                              contentPadding: EdgeInsets.zero,
                            ),
                            cursorColor: theme.colorScheme.primary,
                            cursorWidth: 2,
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

/// Top Bar for Write Screen
class _TopBar extends StatelessWidget {
  final String date;
  final bool isSaving;
  final bool hasChanges;
  final VoidCallback onClose;
  final VoidCallback onSave;

  const _TopBar({
    required this.date,
    required this.isSaving,
    required this.hasChanges,
    required this.onClose,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingSm,
      ),
      child: Row(
        children: [
          // Close button
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
            style: IconButton.styleFrom(
              foregroundColor: theme.textTheme.bodyMedium?.color,
            ),
          ),

          const SizedBox(width: AppDimensions.spacingSm),

          // Date (faded)
          Expanded(
            child: Text(
              date,
              style: AppTypography.dateDisplay(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ),

          // Save indicator / button
          if (isSaving)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (hasChanges)
            TextButton(
              onPressed: onSave,
              child: const Text('Save'),
            )
          else
            const SizedBox(width: 48), // Placeholder for alignment
        ],
      ),
    );
  }
}

