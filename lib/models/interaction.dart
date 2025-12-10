/// Model untuk melacak interaksi user dengan advertisements
class UserInteraction {
  final String id;
  final String adId;
  final String userId;
  final InteractionType type;
  final DateTime timestamp;
  final String? deviceInfo;
  final String? ipAddress;
  final int? durationInSeconds;
  final Map<String, dynamic>? additionalData;

  UserInteraction({
    required this.id,
    required this.adId,
    required this.userId,
    required this.type,
    required this.timestamp,
    this.deviceInfo,
    this.ipAddress,
    this.durationInSeconds,
    this.additionalData,
  });

  factory UserInteraction.fromJson(Map<String, dynamic> json) {
    return UserInteraction(
      id: json['id'] as String,
      adId: json['adId'] as String,
      userId: json['userId'] as String,
      type: InteractionType.values.firstWhere(
        (e) => e.toString() == 'InteractionType.${json['type']}',
        orElse: () => InteractionType.view,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      deviceInfo: json['deviceInfo'] as String?,
      ipAddress: json['ipAddress'] as String?,
      durationInSeconds: json['durationInSeconds'] as int?,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adId': adId,
      'userId': userId,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'deviceInfo': deviceInfo,
      'ipAddress': ipAddress,
      'durationInSeconds': durationInSeconds,
      'additionalData': additionalData,
    };
  }
}

/// Tipe-tipe interaksi yang dapat dilacak
enum InteractionType {
  view, // User melihat ads
  click, // User klik ads
  share, // User share ads
  favorite, // User favorite ads
  pdf_view, // User buka PDF
  cta_click, // User klik call-to-action
  scroll_past, // User scroll past ads
  download, // User download ads
}

/// Model untuk Analytics/Report dari ads
class AdAnalytics {
  final String adId;
  final int totalViews;
  final int totalClicks;
  final int totalShares;
  final int totalFavorites;
  final int totalPdfViews;
  final int totalCtaClicks;
  final int totalDownloads;
  final double engagementRate;
  final double ctrRate; // Click-Through Rate
  final List<InteractionType> topInteractions;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AdAnalytics({
    required this.adId,
    required this.totalViews,
    required this.totalClicks,
    required this.totalShares,
    required this.totalFavorites,
    required this.totalPdfViews,
    required this.totalCtaClicks,
    required this.totalDownloads,
    required this.engagementRate,
    required this.ctrRate,
    required this.topInteractions,
    required this.createdAt,
    this.updatedAt,
  });

  factory AdAnalytics.fromJson(Map<String, dynamic> json) {
    return AdAnalytics(
      adId: json['adId'] as String,
      totalViews: json['totalViews'] as int? ?? 0,
      totalClicks: json['totalClicks'] as int? ?? 0,
      totalShares: json['totalShares'] as int? ?? 0,
      totalFavorites: json['totalFavorites'] as int? ?? 0,
      totalPdfViews: json['totalPdfViews'] as int? ?? 0,
      totalCtaClicks: json['totalCtaClicks'] as int? ?? 0,
      totalDownloads: json['totalDownloads'] as int? ?? 0,
      engagementRate: (json['engagementRate'] as num?)?.toDouble() ?? 0.0,
      ctrRate: (json['ctrRate'] as num?)?.toDouble() ?? 0.0,
      topInteractions: (json['topInteractions'] as List?)
              ?.map((e) => InteractionType.values.firstWhere(
                  (type) => type.toString() == 'InteractionType.$e',
                  orElse: () => InteractionType.view))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adId': adId,
      'totalViews': totalViews,
      'totalClicks': totalClicks,
      'totalShares': totalShares,
      'totalFavorites': totalFavorites,
      'totalPdfViews': totalPdfViews,
      'totalCtaClicks': totalCtaClicks,
      'totalDownloads': totalDownloads,
      'engagementRate': engagementRate,
      'ctrRate': ctrRate,
      'topInteractions':
          topInteractions.map((e) => e.toString().split('.').last).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
