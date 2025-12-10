import 'package:intl/intl.dart';

/// Utility functions untuk formatting
class DateFormatUtils {
  /// Format date ke format string yang readable
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    try {
      final formatter = DateFormat(format, 'id_ID');
      return formatter.format(date);
    } catch (e) {
      return date.toString();
    }
  }

  /// Format date ke format relatif (e.g., "2 hari yang lalu")
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} tahun yang lalu';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} bulan yang lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  /// Check apakah date sudah berlalu
  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check apakah date masih mendatang
  static bool isFutureDate(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Get days remaining
  static int getDaysRemaining(DateTime date) {
    final now = DateTime.now();
    final remaining = date.difference(now).inDays;
    return remaining > 0 ? remaining : 0;
  }
}

/// Utility functions untuk formatting angka
class NumberFormatUtils {
  /// Format number ke format dengan separator (e.g., 1000 -> "1.000")
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (Match match) => '.',
        );
  }

  /// Format percentage
  static String formatPercentage(double value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  /// Format currency
  static String formatCurrency(double amount,
      {String currency = 'Rp', int decimals = 0}) {
    final formatter = formatNumber(amount.toInt());
    return '$currency $formatter';
  }

  /// Format engagement rate
  static String formatEngagementRate(double value) {
    return '${value.toStringAsFixed(2)}%';
  }
}

/// Utility functions untuk string
class StringUtils {
  /// Truncate string dengan ellipsis
  static String truncate(String text, int length) {
    if (text.length > length) {
      return '${text.substring(0, length)}...';
    }
    return text;
  }

  /// Capitalize string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Check apakah string adalah valid URL
  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Extract domain dari URL
  static String extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host;
    } catch (e) {
      return url;
    }
  }
}
