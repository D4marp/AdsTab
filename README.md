# 📱 Ads & Promotions - Flutter Application

Aplikasi Flutter modern untuk menampilkan iklan dan promosi dari berbagai vendor (restoran, hotel, toko, dll) dengan fitur carousel, detail ads, PDF support, dan analytics tracking komprehensif.

## ✨ Fitur Utama

✅ **Carousel Ads Display** - Tampilan carousel otomatis dengan smooth animation  
✅ **Ads List View** - Alternative list view untuk browsing ads  
✅ **Detail Ads Screen** - Halaman detail dengan image gallery & informasi lengkap  
✅ **Analytics Tracking** - Track 8 jenis user interaction  
✅ **Metrics & KPIs** - Engagement rate, CTR, dan top interactions  
✅ **Search & Filter** - Search by keywords, filter by category  
✅ **Favorites Management** - Save & manage favorite ads  
✅ **PDF Support** - View PDF promotions  
✅ **Promo Codes** - Display & copy promo codes  

## 📚 Documentation

### Quick Links
| Document | Purpose |
|----------|---------|
| **[DOCUMENTATION.md](DOCUMENTATION.md)** | 📖 Index semua dokumentasi - **MULAI DARI SINI** |
| **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** | 📋 Ringkasan project lengkap |
| **[QUICKSTART.md](QUICKSTART.md)** | 🚀 Quick start guide & common tasks |
| **[ARCHITECTURE.md](ARCHITECTURE.md)** | 🏗️ System architecture & design |
| **[MODELS.md](MODELS.md)** | 📊 Data models documentation |
| **[ANALYTICS.md](ANALYTICS.md)** | 📈 Analytics & tracking guide |
| **[DIAGRAMS.md](DIAGRAMS.md)** | 📐 Visual diagrams & flows |

👉 **[Baca DOCUMENTATION.md terlebih dahulu untuk overview lengkap!](DOCUMENTATION.md)**

## 🚀 Quick Start

### Prerequisites
- Flutter SDK >= 3.9.0
- Dart >= 3.9.0

### Installation

```bash
# Clone atau navigate ke project
cd adstab

# Install dependencies
flutter pub get

# Run aplikasi
flutter run
```

## 📂 Project Structure

```
lib/
├── main.dart                    # Entry point
├── models/                      # Data models (Advertisement, Vendor, Interaction)
├── providers/                   # State management (AdsProvider, AnalyticsProvider)
├── screens/                     # UI Screens (AdsTabScreen, AdDetailScreen)
├── widgets/                     # UI Components (Carousel, Card, List, Analytics)
├── services/                    # Business logic (AdsService, AnalyticsService)
├── constants/                   # Constants (Colors, Strings)
└── utils/                       # Utilities (DateFormat, Extensions)
```

Lihat [ARCHITECTURE.md](ARCHITECTURE.md) untuk detail lengkap struktur project.

## 🎯 Main Features Breakdown

### 1. Ads Carousel
- Auto-scroll dengan configurable interval
- Swipeable dengan manual navigation
- Indikator page untuk tracking
- Card design dengan vendor info & discount badge

### 2. Analytics Tracking
Track 8 jenis interaksi user:
- **View** - User melihat ads
- **Click** - User tap/click ads
- **Share** - User share ads
- **Favorite** - User add to favorite
- **PDF View** - User buka PDF
- **CTA Click** - User click call-to-action
- **Scroll Past** - User scroll past
- **Download** - User download

### 3. Metrics & Analytics
Calculated in real-time:
- Total Views, Clicks, Shares, Favorites
- **Engagement Rate** = (Clicks + Shares + Favorites) / Views × 100%
- **Click-Through Rate (CTR)** = Clicks / Views × 100%
- **Top Interactions** ranking

Lihat [ANALYTICS.md](ANALYTICS.md) untuk panduan tracking lengkap.

### 4. Search & Filter
- Search by title, description, vendor name
- Filter by category
- Trending ads section
- Favorites management

## 📦 Dependencies

```yaml
# State Management
provider: ^6.1.0

# UI Components
carousel_slider: ^4.2.1
shimmer: ^3.0.0

# Media Handling
pdfrx: ^0.4.0
cached_network_image: ^3.4.0
http: ^1.2.0

# Data & Storage
hive: ^2.2.0
hive_flutter: ^1.1.0
intl: ^0.19.0

# And more...
```

Lihat [pubspec.yaml](pubspec.yaml) untuk full list.

## 🏗️ Architecture

### State Management Pattern
- **Provider Pattern** dengan ChangeNotifier
- Separate providers untuk ads & analytics
- Efficient rebuilding dengan Consumer/watch

### Data Models
- **Advertisement** - Ads/promotions dengan metadata lengkap
- **Vendor** - Business/vendor information
- **UserInteraction** - User interaction tracking
- **AdAnalytics** - Aggregate metrics

Lihat [MODELS.md](MODELS.md) untuk detail model.

### Service Layer
- **AdsService** - Mock data (dapat diganti API real)
- **AnalyticsService** - Tracking & metrics calculation
- **MediaService** - PDF & file handling

## 🎨 UI Components

### Main Screens
- **AdsTabScreen** - Main screen dengan 3 tabs (All, Trending, Favorites)
- **AdDetailScreen** - Detail screen dengan image gallery & analytics

### Reusable Widgets
- **AdsCarousel** - Carousel component
- **AdCarouselCard** - Card untuk carousel
- **AdListTile** - List item
- **AnalyticsIndicator** - Analytics display widget

## 📊 Usage Examples

### Track Ad View
```dart
context.read<AnalyticsProvider>().trackAdView(adId);
```

### Get Ad Analytics
```dart
final analytics = analyticsProvider.getAdAnalytics(adId);
print('Views: ${analytics.totalViews}');
print('CTR: ${analytics.ctrRate.toStringAsFixed(2)}%');
print('Engagement: ${analytics.engagementRate.toStringAsFixed(2)}%');
```

### Search & Filter Ads
```dart
adsProvider.searchAds('pizza');
adsProvider.filterByCategory('Restoran');
adsProvider.resetFilters();
```

Lihat [QUICKSTART.md](QUICKSTART.md) untuk more examples.

## 🔧 Customization

### Change Theme Colors
Edit `lib/constants/colors.dart`

### Change App Strings
Edit `lib/constants/strings.dart`

### Connect to Real API
Update `lib/services/ads_service.dart`

### Add New Interaction Type
1. Add to `InteractionType` enum di `lib/models/interaction.dart`
2. Add tracking method di `lib/services/analytics_service.dart`
3. Call dari UI

Lihat [ARCHITECTURE.md](ARCHITECTURE.md) - Customization section untuk detail.

## 🚀 Production Ready

Aplikasi ini siap untuk:
- ✅ Development dengan mock data
- ✅ Testing dengan sample ads
- ✅ Integration dengan real API
- ✅ User analytics tracking
- ✅ Deployment ke production

### Untuk Production:
1. Connect ke real API
2. Implement user authentication
3. Add error handling & logging
4. Setup analytics backend
5. Implement caching strategy
6. Add tests & CI/CD

## 📝 Documentation Files

| File | Description |
|------|-------------|
| [DOCUMENTATION.md](DOCUMENTATION.md) | Index & guide semua dokumentasi |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | Project completion summary |
| [QUICKSTART.md](QUICKSTART.md) | Setup & common tasks guide |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Complete architecture guide |
| [MODELS.md](MODELS.md) | Data models documentation |
| [ANALYTICS.md](ANALYTICS.md) | Analytics & tracking guide |
| [DIAGRAMS.md](DIAGRAMS.md) | Visual architecture diagrams |

👉 **Start dengan [DOCUMENTATION.md](DOCUMENTATION.md) untuk overview lengkap!**

## 🔮 Future Enhancements

- [ ] Real API integration
- [ ] User authentication & profiles
- [ ] Local caching dengan Hive
- [ ] Push notifications
- [ ] Admin dashboard
- [ ] Advanced analytics dashboard
- [ ] A/B testing framework
- [ ] Offline support
- [ ] Multiple language support
- [ ] Dark mode

Lihat [ARCHITECTURE.md](ARCHITECTURE.md) untuk detailed roadmap.

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ✅ Web (beta)

## 🤝 Contributing

Contributions are welcome! Please follow Flutter style guidelines.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Created with ❤️ for Ads & Promotions Management

---

## 🎯 Getting Started Guide

### For New Developers:
1. Read [DOCUMENTATION.md](DOCUMENTATION.md) - 5 min
2. Read [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - 10 min
3. Follow [QUICKSTART.md](QUICKSTART.md) to setup - 10 min
4. Run `flutter run` and explore
5. Read [ARCHITECTURE.md](ARCHITECTURE.md) for deep dive - 30 min
6. Start coding! 🚀

### For Integration:
1. Read [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture section
2. Check [MODELS.md](MODELS.md) - Data models
3. Update [AdsService](lib/services/ads_service.dart) with your API
4. Update [AnalyticsService](lib/services/analytics_service.dart) with your backend
5. Test thoroughly
6. Deploy! 🎉

---

**[👉 Start with DOCUMENTATION.md](DOCUMENTATION.md)**

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
