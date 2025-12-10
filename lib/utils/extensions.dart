import 'package:intl/intl.dart';

/// Extension methods untuk DateTime
extension DateTimeExtension on DateTime {
  /// Check apakah date adalah hari ini
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check apakah date adalah kemarin
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check apakah date adalah besok
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get bulan dalam bahasa Indonesia
  String get monthIndonesian {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

  /// Format menjadi "dd MMMM yyyy" (e.g., "25 Desember 2025")
  String get formattedIndonesian {
    return '$day ${monthIndonesian} $year';
  }
}

/// Extension methods untuk String
extension StringExtension on String {
  /// Check apakah string kosong atau hanya whitespace
  bool get isNullOrEmpty {
    return isEmpty || trim().isEmpty;
  }

  /// Get first character
  String get firstChar {
    return isEmpty ? '' : this[0];
  }

  /// Get last character
  String get lastChar {
    return isEmpty ? '' : this[length - 1];
  }

  /// Capitalize first character
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Repeat string n times
  String repeat(int times) {
    return this * times;
  }
}

/// Extension methods untuk List<T>
extension ListExtension<T> on List<T> {
  /// Get random element
  T? get random => isEmpty ? null : this[(DateTime.now().millisecondsSinceEpoch) % length];

  /// Remove first element
  void removeFirst() {
    if (isNotEmpty) {
      removeAt(0);
    }
  }

  /// Remove last element
  void removeLast() {
    if (isNotEmpty) {
      removeAt(length - 1);
    }
  }

  /// Get first element atau null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element atau null
  T? get lastOrNull => isEmpty ? null : last;

  /// Check apakah list memiliki single element
  bool get hasSingleElement => length == 1;
}

/// Extension methods untuk num
extension NumExtension on num {
  /// Convert ke duration
  Duration get duration => Duration(milliseconds: toInt());

  /// Check apakah num adalah genap
  bool get isEven => toInt() % 2 == 0;

  /// Check apakah num adalah ganjil
  bool get isOdd => toInt() % 2 != 0;

  /// Convert ke percentage string
  String get toPercentageString => '${toStringAsFixed(1)}%';

  /// Convert ke currency string
  String get toCurrencyString {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}
