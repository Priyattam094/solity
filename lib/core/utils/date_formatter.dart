import 'package:intl/intl.dart';

/// Date formatting utilities for Solity
///
/// Keeps date displays consistent and calm.
class DateFormatter {
  DateFormatter._();

  /// Full date for home screen: "Sunday, December 22"
  static String fullDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  /// Short date for entries: "Dec 22, 2025"
  static String shortDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Entry date with day: "Sun, Dec 22"
  static String entryDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  /// Time only: "2:30 PM"
  static String time(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Relative date for recent entries
  static String relative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final difference = today.difference(dateOnly).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return DateFormat('EEEE').format(date); // "Monday", "Tuesday", etc.
    } else {
      return shortDate(date);
    }
  }

  /// Writing screen date: "December 22, 2025"
  static String writingDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  /// Year only: "2025"
  static String year(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  /// Month and year: "December 2025"
  static String monthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  /// Check if two dates are the same day
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }
}

