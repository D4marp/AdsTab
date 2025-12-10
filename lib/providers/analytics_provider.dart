import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

/// Provider untuk manage analytics dan interaksi user
class AnalyticsProvider extends ChangeNotifier {
  final AnalyticsService _analyticsService = AnalyticsService();

  final Map<String, AdAnalytics> _adAnalytics = {};
  bool _isLoading = false;
  String? _error;
  String _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

  // Getters
  String get userId => _userId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Set user id
  void setUserId(String userId) {
    _userId = userId;
  }

  /// Track ad view
  Future<void> trackAdView(String adId) async {
    try {
      await _analyticsService.trackAdView(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Track ad click
  Future<void> trackAdClick(String adId) async {
    try {
      await _analyticsService.trackAdClick(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Track ad share
  Future<void> trackAdShare(String adId) async {
    try {
      await _analyticsService.trackAdShare(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Track ad favorite
  Future<void> trackAdFavorite(String adId) async {
    try {
      await _analyticsService.trackAdFavorite(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Track PDF view
  Future<void> trackPdfView(String adId) async {
    try {
      await _analyticsService.trackPdfView(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Track CTA click
  Future<void> trackCtaClick(String adId) async {
    try {
      await _analyticsService.trackCtaClick(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Track download
  Future<void> trackDownload(String adId) async {
    try {
      await _analyticsService.trackDownload(adId, _userId);
      _updateAnalytics(adId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Get analytics untuk ad
  AdAnalytics getAdAnalytics(String adId) {
    if (!_adAnalytics.containsKey(adId)) {
      _updateAnalytics(adId);
    }
    return _adAnalytics[adId] ?? _createEmptyAnalytics(adId);
  }

  /// Update analytics
  void _updateAnalytics(String adId) {
    _adAnalytics[adId] = _analyticsService.getAdAnalytics(adId);
    notifyListeners();
  }

  /// Create empty analytics
  AdAnalytics _createEmptyAnalytics(String adId) {
    return AdAnalytics(
      adId: adId,
      totalViews: 0,
      totalClicks: 0,
      totalShares: 0,
      totalFavorites: 0,
      totalPdfViews: 0,
      totalCtaClicks: 0,
      totalDownloads: 0,
      engagementRate: 0,
      ctrRate: 0,
      topInteractions: [],
      createdAt: DateTime.now(),
    );
  }

  /// Get interactions by ad
  List<UserInteraction> getInteractionsByAd(String adId) {
    return _analyticsService.getInteractionsByAd(adId);
  }

  /// Get interactions by user
  List<UserInteraction> getInteractionsByUser() {
    return _analyticsService.getInteractionsByUser(_userId);
  }

  /// Get engagement rate untuk ad
  double getEngagementRate(String adId) {
    return getAdAnalytics(adId).engagementRate;
  }

  /// Get CTR untuk ad
  double getCTR(String adId) {
    return getAdAnalytics(adId).ctrRate;
  }
}
