import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

/// Halaman utama dengan carousel ads
class AdsTabScreen extends StatefulWidget {
  const AdsTabScreen({Key? key}) : super(key: key);

  @override
  State<AdsTabScreen> createState() => _AdsTabScreenState();
}

class _AdsTabScreenState extends State<AdsTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _favoriteIds = {};
  bool _isListView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAds();
  }

  void _loadAds() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdsProvider>().loadAds();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ads & Promotions'),
        elevation: 0,
        actions: [
          /// Toggle view mode
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isListView = !_isListView;
                  });
                },
                child: Icon(
                  _isListView ? Icons.view_agenda : Icons.view_carousel,
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Trending'),
            Tab(text: 'Favorites'),
          ],
          onTap: (index) {
            _handleTabChange(index);
          },
        ),
      ),
      body: Consumer<AdsProvider>(
        builder: (context, adsProvider, _) {
          if (adsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (adsProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${adsProvider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadAds(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              /// All ads tab
              _buildAdsView(
                context,
                adsProvider.filteredAds,
                adsProvider,
              ),

              /// Trending ads tab
              _buildAdsView(
                context,
                adsProvider.filteredAds,
                adsProvider,
                isTrending: true,
              ),

              /// Favorites tab
              _buildAdsView(
                context,
                adsProvider.filteredAds
                    .where((ad) => _favoriteIds.contains(ad.id))
                    .toList(),
                adsProvider,
              ),
            ],
          );
        },
      ),
    );
  }

  /// Build ads view (carousel or list)
  Widget _buildAdsView(
    BuildContext context,
    List<Advertisement> ads,
    AdsProvider adsProvider, {
    bool isTrending = false,
  }) {
    if (ads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isTrending
                  ? 'Tidak ada trending ads'
                  : 'Tidak ada ads yang tersedia',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (_isListView) {
      return ListView.builder(
        itemCount: ads.length,
        itemBuilder: (context, index) {
          final ad = ads[index];
          return AdListTile(
            advertisement: ad,
            isFavorite: _favoriteIds.contains(ad.id),
            onTap: () => _navigateToDetail(context, ad),
            onFavorite: () {
              setState(() {
                if (_favoriteIds.contains(ad.id)) {
                  _favoriteIds.remove(ad.id);
                } else {
                  _favoriteIds.add(ad.id);
                }
              });
              context
                  .read<AnalyticsProvider>()
                  .trackAdFavorite(ad.id);
            },
          );
        },
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              /// Carousel
              AdsCarousel(
                advertisements: ads,
                favoriteIds: _favoriteIds,
                onAdTap: (adId) {
                  final ad = adsProvider.getAdById(adId);
                  if (ad != null) {
                    _navigateToDetail(context, ad);
                  }
                },
                onFavorite: (adId, isFavorite) {
                  setState(() {
                    if (isFavorite) {
                      _favoriteIds.add(adId);
                    } else {
                      _favoriteIds.remove(adId);
                    }
                  });
                  context
                      .read<AnalyticsProvider>()
                      .trackAdFavorite(adId);
                },
              ),

              const SizedBox(height: 24),

              /// Categories filter
              _buildCategoryFilter(context, adsProvider),

              const SizedBox(height: 24),

              /// Search bar
              _buildSearchBar(context, adsProvider),
            ],
          ),
        ),
      );
    }
  }

  /// Build category filter
  Widget _buildCategoryFilter(BuildContext context, AdsProvider adsProvider) {
    final categories = adsProvider.getAllCategories();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: categories.map((category) {
            final isSelected = adsProvider.selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  if (isSelected) {
                    adsProvider.resetFilters();
                  } else {
                    adsProvider.filterByCategory(category);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar(BuildContext context, AdsProvider adsProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onChanged: (value) {
          adsProvider.searchAds(value);
        },
        decoration: InputDecoration(
          hintText: 'Search ads...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  /// Navigate to detail screen
  void _navigateToDetail(BuildContext context, Advertisement advertisement) {
    context.read<AnalyticsProvider>().trackAdView(advertisement.id);
    Navigator.of(context).pushNamed(
      '/ad-detail',
      arguments: advertisement,
    );
  }

  void _handleTabChange(int index) {
    if (index == 1) {
      // Load trending ads
      context.read<AdsProvider>().getTrendingAds();
    } else if (index == 2) {
      // Filter favorites
      // Already handled in filteredAds
    } else {
      // Reset to all ads
      context.read<AdsProvider>().resetFilters();
    }
  }
}
