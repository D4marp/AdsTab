import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

/// Modern Ads Tab Screen dengan Full Carousel di atas
class AdsTabScreen extends StatefulWidget {
  const AdsTabScreen({super.key});

  @override
  State<AdsTabScreen> createState() => _AdsTabScreenState();
}

class _AdsTabScreenState extends State<AdsTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _favoriteIds = {};
  String _searchQuery = '';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Penawaran Terbaik',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Jelajahi deals eksklusif terbaru',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        toolbarHeight: 75,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<AdsProvider>(
        builder: (context, adsProvider, _) {
          if (adsProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading amazing deals...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          if (adsProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red[400],
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Oops! Something went wrong',
                          style: TextStyle(
                            color: Colors.red[900],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${adsProvider.error}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _loadAds(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              /// Full Height Carousel (Top Section)
              Expanded(
                flex: 2,
                child: Column(
                  children: [
              /// Tab Bar - Modern Design
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[600],
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 0,
                        splashBorderRadius: BorderRadius.circular(20),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.3,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        tabs: const [
                          Tab(text: 'Semua'),
                          Tab(text: 'Trending'),
                          Tab(text: 'Favorit'),
                        ],
                      ),
                    ),

                    /// Carousel
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          /// All Ads
                          _buildCarousel(
                            adsProvider.filteredAds,
                            adsProvider,
                          ),

                          /// Trending Ads (sorted by view count)
                          _buildCarousel(
                            _getTrendingAds(adsProvider),
                            adsProvider,
                          ),

                          /// Favorites
                          _buildCarousel(
                            adsProvider.filteredAds
                                .where((ad) => _favoriteIds.contains(ad.id))
                                .toList(),
                            adsProvider,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// Bottom Section: Search Only (Elegant)
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Search Bar - Elegant & Modern
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          adsProvider.searchAds(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari vendor atau penawaran...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey[600],
                            size: 22,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                    adsProvider.searchAds('');
                                  },
                                  child: Icon(
                                    Icons.clear_rounded,
                                    color: Colors.grey[500],
                                    size: 20,
                                  ),
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Build Carousel for each tab
  Widget _buildCarousel(
    List<Advertisement> ads,
    AdsProvider adsProvider,
  ) {
    if (ads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Tidak ada ads',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return SizedBox.expand(
      child: AdsCarousel(
        advertisements: ads,
        onAdTap: (adId) {
          final ad = ads.firstWhere((a) => a.id == adId);
          Navigator.of(context).pushNamed(
            '/ad-detail',
            arguments: ad,
          );
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
        favoriteIds: _favoriteIds,
      ),
    );
  }

  void _handleTabChange(int index) {
    setState(() {});
  }

  /// Get trending ads sorted by view count
  List<Advertisement> _getTrendingAds(AdsProvider adsProvider) {
    final trending = List<Advertisement>.from(adsProvider.filteredAds);
    trending.sort((a, b) => b.viewCount.compareTo(a.viewCount));
    return trending;
  }

  /// Build professional category chip
  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return const SizedBox.shrink();
  }
}

