import 'package:intl/intl.dart';
import 'constants.dart';

/// Utility class for date formatting and manipulation
class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();

  /// Formats a DateTime to DD/MM/YYYY format
  /// Example: 03/11/2026
  static String formatDate(DateTime date) {
    return DateFormat(AppConstants.dateFormatPattern).format(date);
  }

  /// Formats a DateTime to HH:mm format
  /// Example: 14:30
  static String formatTime(DateTime date) {
    return DateFormat(AppConstants.timeFormatPattern).format(date);
  }

  /// Formats a DateTime to DD/MM/YYYY HH:mm format
  /// Example: 03/11/2026 14:30
  static String formatDateTime(DateTime date) {
    return DateFormat(AppConstants.dateTimeFormatPattern).format(date);
  }

  /// Formats a DateTime with day and month name
  /// Example: Lundi 3 Novembre 2026
  static String formatDateWithDayName(DateTime date) {
    return DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(date);
  }

  /// Formats date with custom pattern
  static String formatCustom(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }

  /// Formats date with zero padding (used in your design)
  /// Example: 03/11/2026 (always 2 digits)
  static String formatDatePadded(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  /// Parses a string in DD/MM/YYYY format to DateTime
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat(AppConstants.dateFormatPattern).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Checks if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  /// Checks if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && 
           date.month == tomorrow.month && 
           date.day == tomorrow.day;
  }

  /// Checks if a date is in the past
  static bool isPast(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day));
  }

  /// Checks if a date is in the future
  static bool isFuture(DateTime date) {
    final now = DateTime.now();
    return date.isAfter(DateTime(now.year, now.month, now.day));
  }

  /// Gets the difference in days between two dates
  static int daysBetween(DateTime date1, DateTime date2) {
    final difference = date2.difference(date1);
    return difference.inDays;
  }

  /// Returns a relative date string (Aujourd'hui, Demain, etc.)
  static String getRelativeDateString(DateTime date) {
    if (isToday(date)) {
      return "Aujourd'hui";
    } else if (isTomorrow(date)) {
      return 'Demain';
    } else {
      final days = daysBetween(DateTime.now(), date);
      if (days < 0) {
        return 'Il y a ${days.abs()} jour${days.abs() > 1 ? 's' : ''}';
      } else if (days < 7) {
        return 'Dans $days jour${days > 1 ? 's' : ''}';
      } else {
        return formatDatePadded(date);
      }
    }
  }

  /// Gets the start of the day (00:00:00)
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Gets the end of the day (23:59:59)
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Adds days to a date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Subtracts days from a date
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  /// Gets the current timestamp in milliseconds (for SQLite)
  static int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Converts DateTime to timestamp in milliseconds (for SQLite)
  static int toTimestamp(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  /// Converts timestamp in milliseconds to DateTime (from SQLite)
  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Gets the first day of the month
  static DateTime getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Gets the last day of the month
  static DateTime getLastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Gets the first day of the week (Monday)
  static DateTime getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Gets the last day of the week (Sunday)
  static DateTime getLastDayOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }
}