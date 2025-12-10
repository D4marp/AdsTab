# Ads & Promotions - Flutter Application

Aplikasi Flutter modern untuk menampilkan iklan dan promosi dari berbagai vendor (restoran, hotel, toko, dll). Aplikasi ini dirancang dengan fitur carousel, detail ads, PDF support, dan tracking interaksi user yang komprehensif.

## 🎯 Fitur Utama

### 1. **Ads Carousel**
- Tampilan carousel otomatis untuk ads
- Swipeable carousel dengan smooth animation
- Indikator halaman untuk navigasi
- Mode carousel dan list view yang dapat diubah

### 2. **Detail Ads**
- Tampilan lengkap informasi ads
- Image gallery dengan multiple images
- Promo code yang dapat dicopy
- Date validation dan status tracking
- Call-to-action buttons
- PDF viewer support

### 3. **Analytics & Tracking**
Melacak interaksi user dengan detail metrics:
- **View tracking** - Jumlah user yang melihat ads
- **Click tracking** - Jumlah clicks/taps
- **Share tracking** - Jumlah shares
- **Favorite tracking** - User favorites
- **PDF view tracking** - Pembukaan PDF
- **CTA click tracking** - Click pada call-to-action
- **Download tracking** - Jumlah downloads

### 4. **Metrics & Analytics Display**
- Total views, clicks, shares
- Engagement rate calculation
- Click-through rate (CTR)
- Top interactions ranking
- Real-time analytics updates

### 5. **Search & Filter**
- Search ads berdasarkan title, description, vendor
- Filter by category
- Trending ads section
- Favorites section

## 📁 Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Data models
│   ├── advertisement.dart   # Ad model
│   ├── vendor.dart          # Vendor model
│   ├── interaction.dart     # User interaction & analytics models
│   └── index.dart           # Exports
├── providers/               # State management
│   ├── ads_provider.dart    # Ads state
│   ├── analytics_provider.dart # Analytics state
│   └── index.dart           # Exports
├── screens/                 # UI Screens
│   ├── ads_tab_screen.dart  # Main carousel & list screen
│   ├── ad_detail_screen.dart # Detail screen
│   └── index.dart           # Exports
├── widgets/                 # Reusable components
│   ├── ad_carousel_card.dart # Card untuk carousel
│   ├── ads_carousel.dart    # Carousel widget
│   ├── ad_list_tile.dart    # List item widget
│   ├── analytics_indicator.dart # Analytics display
│   └── index.dart           # Exports
├── services/                # Business logic
│   ├── ads_service.dart     # Ads data service
│   ├── analytics_service.dart # Analytics tracking
│   ├── media_service.dart   # Media handling
│   └── index.dart           # Exports
├── constants/               # Constants
│   ├── colors.dart          # Color definitions
│   ├── strings.dart         # String constants
│   └── index.dart           # Exports
└── utils/                   # Utilities
    ├── format_utils.dart    # Formatting utilities
    ├── extensions.dart      # Dart extensions
    └── index.dart           # Exports
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK >= 3.9.0
- Dart >= 3.9.0

### Installation

1. Clone repository:
```bash
cd adstab
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run aplikasi:
```bash
flutter run
```

## 📦 Dependencies

### State Management
- **provider** ^6.1.0 - State management solution

### UI Components
- **carousel_slider** ^4.2.1 - Carousel widget
- **shimmer** ^3.0.0 - Loading shimmer effect
- **flutter_staggered_grid_view** ^0.7.0 - Staggered grid

### Media Handling
- **pdfrx** ^0.4.0 - PDF viewer
- **cached_network_image** ^3.4.0 - Image caching
- **http** ^1.2.0 - HTTP requests

### Data & Storage
- **hive** ^2.2.0 - Local database
- **hive_flutter** ^1.1.0 - Flutter integration
- **intl** ^0.19.0 - Internationalization

## 🏗️ Architecture

### Models
- **Advertisement** - Data untuk ads/promotions
- **Vendor** - Data untuk vendor (restoran, hotel, dll)
- **UserInteraction** - Tracking interaksi user
- **AdAnalytics** - Analytics metrics

### Providers
- **AdsProvider** - Manage ads list, search, filter
- **AnalyticsProvider** - Manage analytics tracking

### Services
- **AdsService** - Mock data service (dapat diganti API real)
- **AnalyticsService** - Tracking interactions
- **MediaService** - Handle PDF dan file downloads

## 📊 Data Interaksi yang Dilacak

### Jenis Interaksi (InteractionType):
1. **view** - User melihat ads
2. **click** - User click/tap ads
3. **share** - User share ads
4. **favorite** - User favorite ads
5. **pdf_view** - User buka PDF
6. **cta_click** - User click call-to-action
7. **scroll_past** - User scroll past ads
8. **download** - User download ads

### Metrics yang Dihitung:
- **Total Views** - Jumlah views
- **Total Clicks** - Jumlah clicks
- **Total Shares** - Jumlah shares
- **Total Favorites** - Jumlah favorites
- **Total PDF Views** - Jumlah PDF views
- **Total CTA Clicks** - Jumlah CTA clicks
- **Engagement Rate** - (Clicks + Shares + Favorites) / Views × 100%
- **Click-Through Rate (CTR)** - Clicks / Views × 100%
- **Top Interactions** - 3 interaksi teratas

## 🎨 UI Components

### AdsCarousel
Carousel untuk menampilkan ads dengan features:
- Auto-scroll dengan interval configurable
- Manual navigation dengan dots
- Image dengan overlay
- Vendor info dan discount badge
- Favorite button

### AdListTile
List item untuk ads dengan:
- Image thumbnail
- Vendor info
- Title dan description
- Engagement metrics
- Favorite button

### AnalyticsIndicator
Display analytics metrics dengan:
- Grid metrics cards
- Progress bars untuk engagement rates
- Color coding untuk performance

## 🔧 Customization

### Mengganti Mock Data dengan API Real
1. Update `AdsService` untuk fetch dari API:
```dart
Future<List<Advertisement>> getAllAds() async {
  final response = await http.get(Uri.parse('https://api.example.com/ads'));
  // Parse response
}
```

2. Update `AnalyticsService` untuk send tracking ke server:
```dart
Future<void> trackInteraction(UserInteraction interaction) async {
  await http.post(
    Uri.parse('https://api.example.com/track'),
    body: jsonEncode(interaction.toJson()),
  );
}
```

### Menambah Analytics Metrics
1. Update `InteractionType` enum
2. Update `AdAnalytics` model
3. Update `AnalyticsService` tracking method

### Styling & Theming
- Update `AppColors` di `lib/constants/colors.dart`
- Update theme di `main.dart`
- Update `AppStrings` untuk text

## 📱 Screen Flow

```
AdsTabScreen (Utama)
├── All Ads Tab
│   ├── Carousel View
│   └── List View
├── Trending Tab
│   └── Trending Ads
└── Favorites Tab
    └── Favorite Ads

AdDetailScreen (Detail)
├── Image Gallery
├── Vendor Info
├── Description
├── Promo Code
├── Categories
├── Date Info
├── Analytics Indicator
└── Action Buttons (CTA, PDF, Share)
```

## 🎯 Usage Examples

### Track Ad View
```dart
context.read<AnalyticsProvider>().trackAdView(adId);
```

### Track Ad Click
```dart
context.read<AnalyticsProvider>().trackAdClick(adId);
```

### Get Ad Analytics
```dart
final analytics = analyticsProvider.getAdAnalytics(adId);
print('Views: ${analytics.totalViews}');
print('CTR: ${analytics.ctrRate}%');
print('Engagement: ${analytics.engagementRate}%');
```

### Search & Filter
```dart
adsProvider.searchAds('pizza');
adsProvider.filterByCategory('Restoran');
adsProvider.resetFilters();
```

## 🚧 Future Enhancements

- [ ] Real PDF viewer implementation
- [ ] Share functionality integration
- [ ] Location-based ads filtering
- [ ] User preferences & recommendations
- [ ] Advanced analytics dashboard
- [ ] Admin panel untuk manage ads
- [ ] Push notifications
- [ ] Offline support with local caching
- [ ] Multiple language support
- [ ] Dark mode support

## 📝 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Created with ❤️ for Ads & Promotions management
