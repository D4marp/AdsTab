/// Tipe media yang didukung
enum AdMediaType {
  image,
  pdf,
  video,
}

/// Status ads
enum AdStatus {
  active,
  inactive,
  scheduled,
  expired,
}

/// Model untuk Advertisement/Promosi
class Advertisement {
  final String id;
  final String vendorId;
  final String vendorName;
  final String vendorLogo;
  final String title;
  final String description;
  final String? longDescription;
  final List<String> imageUrls;
  final String? pdfUrl;
  final AdMediaType mediaType;
  final AdStatus status;
  final DateTime startDate;
  final DateTime? endDate;
  final int? discountPercentage;
  final String? promoCode;
  final String? callToActionText;
  final String? callToActionUrl;
  final List<String> categories;
  final int viewCount;
  final int clickCount;
  final int shareCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isFavorite;

  Advertisement({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.vendorLogo,
    required this.title,
    required this.description,
    this.longDescription,
    required this.imageUrls,
    this.pdfUrl,
    this.mediaType = AdMediaType.image,
    this.status = AdStatus.active,
    required this.startDate,
    this.endDate,
    this.discountPercentage,
    this.promoCode,
    this.callToActionText,
    this.callToActionUrl,
    required this.categories,
    this.viewCount = 0,
    this.clickCount = 0,
    this.shareCount = 0,
    required this.createdAt,
    this.updatedAt,
    this.isFavorite = false,
  });

  /// Cek apakah ads masih aktif berdasarkan tanggal
  bool get isCurrentlyActive {
    final now = DateTime.now();
    final isAfterStart = now.isAfter(startDate);
    final isBeforeEnd = endDate == null || now.isBefore(endDate!);
    return status == AdStatus.active && isAfterStart && isBeforeEnd;
  }

  /// Hitung engagement rate
  double get engagementRate {
    if (viewCount == 0) return 0;
    return ((clickCount + shareCount) / viewCount) * 100;
  }

  /// Copy with untuk membuat instance baru dengan perubahan
  Advertisement copyWith({
    String? id,
    String? vendorId,
    String? vendorName,
    String? vendorLogo,
    String? title,
    String? description,
    String? longDescription,
    List<String>? imageUrls,
    String? pdfUrl,
    AdMediaType? mediaType,
    AdStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int? discountPercentage,
    String? promoCode,
    String? callToActionText,
    String? callToActionUrl,
    List<String>? categories,
    int? viewCount,
    int? clickCount,
    int? shareCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return Advertisement(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      vendorLogo: vendorLogo ?? this.vendorLogo,
      title: title ?? this.title,
      description: description ?? this.description,
      longDescription: longDescription ?? this.longDescription,
      imageUrls: imageUrls ?? this.imageUrls,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      mediaType: mediaType ?? this.mediaType,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      promoCode: promoCode ?? this.promoCode,
      callToActionText: callToActionText ?? this.callToActionText,
      callToActionUrl: callToActionUrl ?? this.callToActionUrl,
      categories: categories ?? this.categories,
      viewCount: viewCount ?? this.viewCount,
      clickCount: clickCount ?? this.clickCount,
      shareCount: shareCount ?? this.shareCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'] as String,
      vendorId: json['vendorId'] as String,
      vendorName: json['vendorName'] as String,
      vendorLogo: json['vendorLogo'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      longDescription: json['longDescription'] as String?,
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
      pdfUrl: json['pdfUrl'] as String?,
      mediaType: AdMediaType.values.firstWhere(
        (e) => e.toString() == 'AdMediaType.${json['mediaType']}',
        orElse: () => AdMediaType.image,
      ),
      status: AdStatus.values.firstWhere(
        (e) => e.toString() == 'AdStatus.${json['status']}',
        orElse: () => AdStatus.active,
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate:
          json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      discountPercentage: json['discountPercentage'] as int?,
      promoCode: json['promoCode'] as String?,
      callToActionText: json['callToActionText'] as String?,
      callToActionUrl: json['callToActionUrl'] as String?,
      categories: List<String>.from(json['categories'] as List? ?? []),
      viewCount: json['viewCount'] as int? ?? 0,
      clickCount: json['clickCount'] as int? ?? 0,
      shareCount: json['shareCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'vendorLogo': vendorLogo,
      'title': title,
      'description': description,
      'longDescription': longDescription,
      'imageUrls': imageUrls,
      'pdfUrl': pdfUrl,
      'mediaType': mediaType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'discountPercentage': discountPercentage,
      'promoCode': promoCode,
      'callToActionText': callToActionText,
      'callToActionUrl': callToActionUrl,
      'categories': categories,
      'viewCount': viewCount,
      'clickCount': clickCount,
      'shareCount': shareCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }
}
