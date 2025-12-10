import '../models/index.dart';
import 'dart:async';

/// Service untuk melacak interaksi user dengan ads
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  final List<UserInteraction> _interactions = [];
  final Map<String, int> _interactionCounts = {};

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal();

  /// Catat interaksi user
  Future<void> trackInteraction({
    required String adId,
    required String userId,
    required InteractionType type,
    String? deviceInfo,
    String? ipAddress,
    int? durationInSeconds,
    Map<String, dynamic>? additionalData,
  }) async {
    final interaction = UserInteraction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      adId: adId,
      userId: userId,
      type: type,
      timestamp: DateTime.now(),
      deviceInfo: deviceInfo,
      ipAddress: ipAddress,
      durationInSeconds: durationInSeconds,
      additionalData: additionalData,
    );

    _interactions.add(interaction);
    _updateInteractionCounts(type, adId);

    // TODO: Send to server
    // await _sendInteractionToServer(interaction);
  }

  /// Track view
  Future<void> trackAdView(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.view,
    );
  }

  /// Track click
  Future<void> trackAdClick(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.click,
    );
  }

  /// Track share
  Future<void> trackAdShare(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.share,
    );
  }

  /// Track favorite
  Future<void> trackAdFavorite(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.favorite,
    );
  }

  /// Track PDF view
  Future<void> trackPdfView(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.pdf_view,
    );
  }

  /// Track CTA click
  Future<void> trackCtaClick(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.cta_click,
    );
  }

  /// Track download
  Future<void> trackDownload(String adId, String userId) async {
    await trackInteraction(
      adId: adId,
      userId: userId,
      type: InteractionType.download,
    );
  }

  /// Dapatkan analytics untuk ads tertentu
  AdAnalytics getAdAnalytics(String adId) {
    final adInteractions =
        _interactions.where((i) => i.adId == adId).toList();

    int totalViews = 0,
        totalClicks = 0,
        totalShares = 0,
        totalFavorites = 0,
        totalPdfViews = 0,
        totalCtaClicks = 0,
        totalDownloads = 0;

    for (final interaction in adInteractions) {
      switch (interaction.type) {
        case InteractionType.view:
          totalViews++;
          break;
        case InteractionType.click:
          totalClicks++;
          break;
        case InteractionType.share:
          totalShares++;
          break;
        case InteractionType.favorite:
          totalFavorites++;
          break;
        case InteractionType.pdf_view:
          totalPdfViews++;
          break;
        case InteractionType.cta_click:
          totalCtaClicks++;
          break;
        case InteractionType.download:
          totalDownloads++;
          break;
        case InteractionType.scroll_past:
          break;
      }
    }

    final totalInteractions =
        totalClicks + totalShares + totalFavorites + totalCtaClicks;
    final engagementRate = totalViews > 0
        ? (totalInteractions / totalViews) * 100
        : 0.0;
    final ctrRate =
        totalViews > 0 ? (totalClicks / totalViews) * 100 : 0.0;

    return AdAnalytics(
      adId: adId,
      totalViews: totalViews,
      totalClicks: totalClicks,
      totalShares: totalShares,
      totalFavorites: totalFavorites,
      totalPdfViews: totalPdfViews,
      totalCtaClicks: totalCtaClicks,
      totalDownloads: totalDownloads,
      engagementRate: engagementRate,
      ctrRate: ctrRate,
      topInteractions: _getTopInteractions(adInteractions),
      createdAt: DateTime.now(),
    );
  }

  /// Dapatkan interaksi untuk ads
  List<UserInteraction> getInteractionsByAd(String adId) {
    return _interactions.where((i) => i.adId == adId).toList();
  }

  /// Dapatkan interaksi untuk user
  List<UserInteraction> getInteractionsByUser(String userId) {
    return _interactions.where((i) => i.userId == userId).toList();
  }

  /// Hitung top interactions
  List<InteractionType> _getTopInteractions(List<UserInteraction> interactions) {
    final counts = <InteractionType, int>{};
    for (final interaction in interactions) {
      counts[interaction.type] = (counts[interaction.type] ?? 0) + 1;
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.take(3).map((e) => e.key).toList();
  }

  /// Update interaction counts
  void _updateInteractionCounts(InteractionType type, String adId) {
    final key = '${adId}_${type.toString()}';
    _interactionCounts[key] = (_interactionCounts[key] ?? 0) + 1;
  }

  /// Clear all interactions (untuk testing)
  void clearInteractions() {
    _interactions.clear();
    _interactionCounts.clear();
  }
}
