# Quick Start Guide

## Setup Aplikasi

### 1. Instalasi Dependencies
```bash
cd adstab
flutter pub get
```

### 2. Run Aplikasi
```bash
flutter run
```

## Struktur Folder Utama

```
adstab/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── models/                      # Data models
│   ├── providers/                   # State management
│   ├── screens/                     # UI screens
│   ├── widgets/                     # Reusable components
│   ├── services/                    # Business logic
│   ├── constants/                   # Constants
│   └── utils/                       # Utilities
├── ARCHITECTURE.md                  # Architecture documentation
├── MODELS.md                        # Data models documentation
├── ANALYTICS.md                     # Analytics guide
└── README.md                        # Main README
```

## File Penting

### Model Files (lib/models/)
1. **advertisement.dart** - Model untuk ads/promotions
2. **vendor.dart** - Model untuk vendor (restoran, hotel, dll)
3. **interaction.dart** - Model untuk tracking & analytics

### Provider Files (lib/providers/)
1. **ads_provider.dart** - State management untuk ads
2. **analytics_provider.dart** - State management untuk analytics

### Screen Files (lib/screens/)
1. **ads_tab_screen.dart** - Main screen dengan carousel & list
2. **ad_detail_screen.dart** - Detail screen untuk single ad

### Widget Files (lib/widgets/)
1. **ads_carousel.dart** - Carousel component
2. **ad_carousel_card.dart** - Card untuk carousel
3. **ad_list_tile.dart** - List item
4. **analytics_indicator.dart** - Analytics display

### Service Files (lib/services/)
1. **ads_service.dart** - Ads data service (mock)
2. **analytics_service.dart** - Analytics tracking
3. **media_service.dart** - PDF & file handling

## Key Features

### 1. Carousel Display
- Auto-scroll dengan kontrol manual
- Multiple images per ads
- Vendor info & discount badge
- Favorite button

### 2. Analytics Tracking
Track 8 jenis interaksi:
- View, Click, Share
- Favorite, PDF View, CTA Click
- Scroll Past, Download

### 3. Metrics & KPIs
- Total Views, Clicks, Shares
- Engagement Rate
- Click-Through Rate (CTR)
- Top Interactions

### 4. Search & Filter
- Search by title/description/vendor
- Filter by category
- Trending ads section
- Favorites management

## Common Tasks

### Add New Ad Type
1. Update `AdMediaType` enum in `models/advertisement.dart`
2. Update `AdsService.getAllAds()` untuk include new type
3. Update UI widgets untuk handle new type

### Track New Interaction
1. Add `InteractionType` enum value di `models/interaction.dart`
2. Add tracking method di `services/analytics_service.dart`
3. Call tracking method dari UI widget

### Connect to Real API
1. Update `AdsService`:
```dart
Future<List<Advertisement>> getAllAds() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/ads'),
  );
  // Parse and return data
}
```

2. Update `AnalyticsService`:
```dart
Future<void> trackInteraction(UserInteraction interaction) async {
  await http.post(
    Uri.parse('https://api.example.com/track'),
    body: jsonEncode(interaction.toJson()),
  );
}
```

### Customize UI Theme
1. Update colors di `constants/colors.dart`
2. Update strings di `constants/strings.dart`
3. Update theme di `main.dart`

## Navigation

### Main App Routes
```dart
/                     // AdsTabScreen (default)
/ad-detail           // AdDetailScreen (with Ad argument)
```

### Add New Route
1. Define route di `main.dart` `onGenerateRoute`
2. Create screen file di `screens/`
3. Navigate using `Navigator.of(context).pushNamed()`

## State Management

### Using ChangeNotifier (Provider)
```dart
// Access provider
final adsProvider = context.read<AdsProvider>();
final analyticsProvider = context.watch<AnalyticsProvider>();

// Listen to changes
Consumer<AdsProvider>(
  builder: (context, provider, _) {
    // Rebuild when provider changes
  },
)
```

### Common Provider Methods

**AdsProvider:**
```dart
adsProvider.loadAds();              // Load all ads
adsProvider.searchAds(query);       // Search ads
adsProvider.filterByCategory(cat);  // Filter by category
adsProvider.getTrendingAds();       // Get trending ads
adsProvider.resetFilters();         // Reset all filters
```

**AnalyticsProvider:**
```dart
analyticsProvider.trackAdView(adId);        // Track view
analyticsProvider.trackAdClick(adId);       // Track click
analyticsProvider.trackAdShare(adId);       // Track share
analyticsProvider.getAdAnalytics(adId);     // Get metrics
```

## Mock Data

Current implementation menggunakan mock data dari `AdsService.getAllAds()`.

Mock data includes:
- 6 sample ads
- Different vendors (Restaurant, Hotel, Fashion, Beauty)
- Various discount percentages
- Multiple images per ad
- Sample metrics (views, clicks, shares)

## Testing

### Run Tests
```bash
flutter test
```

### Test Coverage
```bash
flutter test --coverage
```

## Debugging

### Enable Debug Logging
```dart
// In services
print('Debug: Tracking interaction...');
```

### Use DevTools
```bash
flutter pub global activate devtools
devtools
```

### Check State Changes
```dart
// Use Provider DevTools extension
// Available in VS Code/Android Studio
```

## Common Issues & Solutions

### Issue: Provider not found
**Solution:** Make sure providers are wrapped in MultiProvider in main.dart

### Issue: Carousel not scrolling
**Solution:** Check carousel height and viewport settings

### Issue: Analytics not tracking
**Solution:** Ensure AnalyticsProvider is initialized and user ID is set

### Issue: Images not loading
**Solution:** Check image URLs are valid and accessible

## Performance Tips

1. **Lazy Loading**
   - Load ads on demand
   - Implement pagination

2. **Image Optimization**
   - Use cached_network_image
   - Compress images before upload

3. **Provider Efficiency**
   - Use `read()` instead of `watch()` when not rebuilding
   - Limit Consumer scope

4. **List Performance**
   - Use ListView.builder instead of ListView
   - Implement item caching

## Next Steps

1. **Connect Real API**
   - Update AdsService endpoints
   - Implement error handling

2. **Add Authentication**
   - Integrate login/signup
   - Track user-specific analytics

3. **Implement Local Storage**
   - Cache ads with Hive
   - Store favorites locally

4. **Add Push Notifications**
   - Notify users of new ads
   - Alert for ending promotions

5. **Create Admin Dashboard**
   - Manage ads
   - View analytics
   - Create reports

## Resources

- **Flutter Documentation**: https://flutter.dev/docs
- **Provider Package**: https://pub.dev/packages/provider
- **Carousel Slider**: https://pub.dev/packages/carousel_slider
- **Intl Package**: https://pub.dev/packages/intl

## Support & Questions

For questions or issues:
1. Check ARCHITECTURE.md for system design
2. Check MODELS.md for data models
3. Check ANALYTICS.md for analytics guide
4. Review code comments in relevant files

## Version Info

- **Dart**: 3.9.0+
- **Flutter**: 3.9.0+
- **Android**: API 21+
- **iOS**: 11.0+

---

**Happy Coding! 🚀**
