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
        title: const Text('Ads & Promotions'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Icon(Icons.widgets_outlined, color: Colors.grey[600]),
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
                    /// Tab Bar
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 3,
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

                          /// Trending Ads
                          _buildCarousel(
                            adsProvider.getTrendingAds(),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Category Filter
                    if (adsProvider.getAllCategories().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kategori',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  /// All button
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8),
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
                                      labelStyle: TextStyle(
                                        color: _selectedCategory == null
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 12,
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
                                      padding: const EdgeInsets.only(
                                          right: 8),
                                      child: FilterChip(
                                        label: Text(category),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          setState(() {
                                            _selectedCategory = selected
                                                ? category
                                                : null;
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
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 12,
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
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          adsProvider.searchAds(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search ads...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.search,
                              color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
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
}
