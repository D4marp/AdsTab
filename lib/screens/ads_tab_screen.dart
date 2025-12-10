import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../widgets/index.dart';
import 'ad_detail_screen.dart';

/// Modern Ads Tab Screen dengan Full Carousel di atas
class AdsTabScreen extends StatefulWidget {
  const AdsTabScreen({Key? key}) : super(key: key);

  @override
  State<AdsTabScreen> createState() => _AdsTabScreenState();
}

class _AdsTabScreenState extends State<AdsTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _favoriteIds = {};
  String _searchQuery = '';
  String? _selectedCategory;

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
        title: const Text(
          'Ads & Promotions',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.grid_view_rounded, 
                    color: Colors.grey[700],
                    size: 22,
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

          return Column(
            children: [
              /// Full Height Carousel (Top Section)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    /// Tab Bar - Modern Design
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        tabs: const [
                          Tab(text: 'All'),
                          Tab(text: 'Trending'),
                          Tab(text: 'Favorites'),
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

              /// Bottom Section: Categories + Search (Fixed)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Category Filter
                    if (adsProvider.getAllCategories().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kategori',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  /// All button
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      label: const Text('Semua'),
                                      selected: _selectedCategory == null,
                                      onSelected: (selected) {
                                        setState(() {
                                          _selectedCategory = null;
                                        });
                                        adsProvider.resetFilters();
                                      },
                                      backgroundColor: Colors.grey[100],
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                      side: BorderSide.none,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      labelStyle: TextStyle(
                                        color: _selectedCategory == null
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  /// Category chips
                                  ...adsProvider
                                      .getAllCategories()
                                      .map((category) {
                                    final isSelected =
                                        _selectedCategory == category;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: FilterChip(
                                        label: Text(category),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          setState(() {
                                            _selectedCategory =
                                                selected ? category : null;
                                          });
                                          if (selected) {
                                            adsProvider
                                                .filterByCategory(category);
                                          } else {
                                            adsProvider.resetFilters();
                                          }
                                        },
                                        backgroundColor: Colors.grey[100],
                                        selectedColor:
                                            Theme.of(context).primaryColor,
                                        side: BorderSide.none,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    /// Search Bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          adsProvider.searchAds(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search ads...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                            size: 20,
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
                                    Icons.close,
                                    color: Colors.grey[400],
                                    size: 18,
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
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
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
}
