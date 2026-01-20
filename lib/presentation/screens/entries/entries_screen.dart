import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../domain/entities/diary_entry.dart';
import '../../providers/diary_providers.dart';

/// Entries Screen - "Your Pages"
///
/// Vertical list of entries with search. Each entry is a card.
/// No word count. No analytics. No streaks.
class EntriesScreen extends ConsumerStatefulWidget {
  const EntriesScreen({super.key});

  @override
  ConsumerState<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends ConsumerState<EntriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DiaryEntry> _filterEntries(List<DiaryEntry> entries) {
    if (_searchQuery.isEmpty) return entries;

    final query = _searchQuery.toLowerCase();
    return entries.where((entry) {
      return entry.content.toLowerCase().contains(query) ||
          DateFormatter.fullDate(entry.createdAt).toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(diaryNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? _SearchField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                onClear: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
              )
            : const Text('Your Pages'),
        centerTitle: !_isSearching,
        actions: [
          IconButton(
            icon: Icon(
                _isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                }
              });
            },
          ),
        ],
      ),
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return _EmptyState();
          }

          final filteredEntries = _filterEntries(entries);

          if (filteredEntries.isEmpty && _searchQuery.isNotEmpty) {
            return _NoSearchResults(query: _searchQuery);
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(diaryNotifierProvider.notifier).refresh(),
            child: ListView.builder(
              padding: AppDimensions.pagePadding,
              itemCount: filteredEntries.length,
              itemBuilder: (context, index) {
                final entry = filteredEntries[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
                  child: _EntryCard(
                    entry: entry,
                    searchQuery: _searchQuery,
                    onTap: () => context.push('/write/${entry.id}'),
                    onDelete: () => _confirmDelete(context, ref, entry),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: AppDimensions.spacingMd),
              Text(
                'Something went wrong',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: AppDimensions.spacingSm),
              TextButton(
                onPressed: () => ref.read(diaryNotifierProvider.notifier).refresh(),
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete entry?'),
        content: const Text('This action cannot be undone.'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(diaryNotifierProvider.notifier).deleteEntry(entry.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Search Field Widget
class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      autofocus: true,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: 'Search entries...',
        hintStyle: AppTypography.bodyMedium(
          color: theme.textTheme.bodySmall?.color,
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded, size: 20),
                onPressed: onClear,
              )
            : null,
      ),
    );
  }
}

/// No search results state
class _NoSearchResults extends StatelessWidget {
  final String query;

  const _NoSearchResults({required this.query});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            Text(
              'No results found',
              style: AppTypography.headlineMedium(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'No entries match "$query"',
              style: AppTypography.bodyMedium(
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state when no entries exist
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.book_outlined,
              size: 64,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            Text(
              'No entries yet',
              style: AppTypography.headlineMedium(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Your thoughts will appear here',
              style: AppTypography.bodyMedium(
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Entry Card
///
/// Shows date and preview. Feels like paper, not tile.
class _EntryCard extends StatelessWidget {
  final DiaryEntry entry;
  final String searchQuery;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _EntryCard({
    required this.entry,
    this.searchQuery = '',
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onDelete,
      child: Container(
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
            // Date row
            Row(
              children: [
                Text(
                  DateFormatter.entryDate(entry.createdAt),
                  style: AppTypography.labelMedium(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormatter.time(entry.createdAt),
                  style: AppTypography.labelSmall(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.spacingSm),

            // Content preview with highlight
            _HighlightedText(
              text: entry.preview.isEmpty ? 'Empty entry' : entry.preview,
              query: searchQuery,
              style: AppTypography.bodyMedium(
                color: entry.preview.isEmpty
                    ? theme.textTheme.bodySmall?.color
                    : theme.textTheme.bodyMedium?.color,
              ),
              highlightColor: theme.colorScheme.primary.withValues(alpha: 0.2),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget to highlight search query in text
class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? style;
  final Color highlightColor;
  final int maxLines;

  const _HighlightedText({
    required this.text,
    required this.query,
    this.style,
    required this.highlightColor,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: TextStyle(
          backgroundColor: highlightColor,
          fontWeight: FontWeight.w600,
        ),
      ));

      start = index + query.length;
    }

    return RichText(
      text: TextSpan(
        style: style,
        children: spans,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
