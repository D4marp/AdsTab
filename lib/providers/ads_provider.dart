import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

/// Provider untuk manage state ads list
class AdsProvider extends ChangeNotifier {
  final AdsService _adsService = AdsService();
  final AnalyticsService _analyticsService = AnalyticsService();

  List<Advertisement> _allAds = [];
  List<Advertisement> _filteredAds = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  // Getters
  List<Advertisement> get allAds => _allAds;
  List<Advertisement> get filteredAds => _filteredAds;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  /// Load semua ads
  Future<void> loadAds() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allAds = await _adsService.getAllAds();
      _filteredAds = List.from(_allAds);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Search ads
  Future<void> searchAds(String query) async {
    _searchQuery = query;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (query.isEmpty) {
        _filteredAds = List.from(_allAds);
      } else {
        _filteredAds = await _adsService.searchAds(query);
      }
      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  /// Apply all filters
  void _applyFilters() {
    List<Advertisement> result = List.from(_allAds);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((ad) =>
              ad.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              ad.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              ad.vendorName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filter
    if (_selectedCategory != 'Semua') {
      result = result
          .where((ad) => ad.categories.contains(_selectedCategory))
          .toList();
    }

    _filteredAds = result;
  }

  /// Get trending ads
  Future<void> getTrendingAds() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _filteredAds = await _adsService.getTrendingAds(limit: 20);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Track ad view
  Future<void> trackAdView(String adId, String userId) async {
    try {
      await _analyticsService.trackAdView(adId, userId);
    } catch (e) {
      print('Error tracking view: $e');
    }
  }

  /// Get ad by id
  Advertisement? getAdById(String adId) {
    try {
      return _allAds.firstWhere((ad) => ad.id == adId);
    } catch (e) {
      return null;
    }
  }

  /// Get all categories
  List<String> getAllCategories() {
    final Set<String> categories = {'Semua'};
    for (final ad in _allAds) {
      categories.addAll(ad.categories);
    }
    return categories.toList()..sort();
  }

  /// Get ads by vendor
  List<Advertisement> getAdsByVendor(String vendorId) {
    return _allAds.where((ad) => ad.vendorId == vendorId).toList();
  }

  /// Reset filters
  void resetFilters() {
    _searchQuery = '';
    _selectedCategory = 'Semua';
    _filteredAds = List.from(_allAds);
    notifyListeners();
  }
}
