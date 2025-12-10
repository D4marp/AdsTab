# 🚀 Quick Start - Menjalankan Aplikasi

## Setup & Run

### 1. Install Dependencies
```bash
cd adstab
flutter pub get
```

### 2. Run Application
```bash
flutter run
```

Aplikasi akan membuka dengan mock data yang sudah tersedia.

---

## 📱 UI Flow & Features yang Sudah Siap

### **Screen 1: Ads Tab Screen (Home)**
```
┌─────────────────────────┐
│  Ads & Promotions       │
├─────────────────────────┤
│                         │
│   [Carousel Slider]     │
│   Image + Vendor Info   │
│   • Auto-scroll 5sec    │
│   • Manual swipe        │
│   • Page indicator      │
│   • Favorite button     │
│                         │
├─────────────────────────┤
│ 🔄 Toggle View Button   │
│  Carousel ↔ List        │
├─────────────────────────┤
│ [All] [Trending] [❤️]   │ ← 3 Tabs
├─────────────────────────┤
│ 🔍 Search Bar           │
│ 📂 Category Filter      │
├─────────────────────────┤
│ • Ad 1 (Restaurant)     │
│ • Ad 2 (Hotel)          │
│ • Ad 3 (Fashion)        │
│ • ... (List View)       │
└─────────────────────────┘
```

**Features:**
- ✅ Carousel display dengan auto-scroll
- ✅ Manual swipe & page indicator dots
- ✅ Toggle Carousel ↔ List view
- ✅ 3 Tabs: All, Trending, Favorites
- ✅ Search functionality
- ✅ Category filter (Restaurant, Hotel, Fashion, Beauty)
- ✅ Favorite toggle with heart icon
- ✅ Click to navigate to detail screen

---

### **Screen 2: Ad Detail Screen**
```
┌─────────────────────────────┐
│ ← Back  Ad Detail  ❤️        │
├─────────────────────────────┤
│                             │
│  [Image Gallery]            │
│  ← Image 1/2 →              │ ← Multiple images
│  ........................    │
│  1 / 2                      │
│                             │
├─────────────────────────────┤
│ 🏪 Restaurant Paradise      │ ← Vendor Info
│ 📍 Jakarta, Indonesia       │
│ ⭐ 4.5 (1,250 reviews)      │
│                             │
│ Diskon 50% Menu Spesial     │ ← Title
│                             │
│ Nikmati diskon besar-besar..│ ← Description
│                             │
├─────────────────────────────┤
│ Promo Code:                 │
│ ┌──────────────────────────┐│
│ │ PARADISE50  [📋 Copy]    ││
│ └──────────────────────────┘│
│ Discount: 50%               │
│                             │
├─────────────────────────────┤
│ 📅 Berlaku: 10/12/2025      │
│ 📅 Berakhir: 09/01/2026     │
│                             │
├─────────────────────────────┤
│ Kategori:                   │
│ [Restoran] [Food] [Diskon]  │
│                             │
├─────────────────────────────┤
│ 📊 Analytics:               │
│ ┌─────────┬─────────────┐   │
│ │Views: 1250 │ 3/5 ████│   │ ← AnalyticsIndicator
│ │Clicks: 180 │ 3/5 ████│   │
│ │Shares: 45  │ 1/5 ██  │   │
│ │Favorites:14│ 1/5 ██  │   │
│ └─────────┴─────────────┘   │
│ Engagement: 16% ████        │
│ CTR: 14% ████               │
│                             │
├─────────────────────────────┤
│ [🎯 Pesan Sekarang]         │ ← CTA Button
│ [📄 Lihat PDF]              │ ← PDF Button
│ [📤 Bagikan]                │ ← Share Button
└─────────────────────────────┘
```

**Features:**
- ✅ Image gallery dengan PageView
- ✅ Multiple images dengan dot indicators
- ✅ Vendor info display (logo, name, location, rating)
- ✅ Promo code with copy button
- ✅ Discount percentage display
- ✅ Start & end date display
- ✅ Categories chips
- ✅ Analytics metrics (Views, Clicks, Shares, Favorites, PDF Views, Downloads)
- ✅ Engagement Rate & CTR with progress bars
- ✅ Call-to-Action button
- ✅ PDF viewer button
- ✅ Share button
- ✅ Favorite toggle

---

### **Screen 3: PDF Viewer Screen**
```
┌──────────────────────────────┐
│ ← Back  PDF Title            │
├──────────────────────────────┤
│                              │
│        📄 PDF Loaded          │
│                              │
│   /path/to/pdf/file.pdf      │
│                              │
│   File Size: 4.42 MB         │
│                              │
│   [🔗 Open PDF Viewer]       │ ← Future implementation
│                              │
└──────────────────────────────┘
```

**Features:**
- ✅ Load PDF dari assets folder
- ✅ Support PDF dari URL
- ✅ Show file path & size
- ✅ Loading state with spinner
- ✅ Error handling
- ✅ Ready untuk integrasi dengan pdfrx package

---

## 📊 Data Structure

### Mock Data (6 Sample Ads)
```
1. Restaurant Paradise - 50% Diskon
   - Type: Image
   - Status: Active
   - Vendor: Restaurant
   - Images: 2
   - PDF: None

2. Luxury Hotel Bintang Lima - Paket Honeymoon
   - Type: PDF
   - Status: Active
   - Vendor: Hotel
   - Images: 2
   - PDF: assets/pdf/Solution Package 2025.pdf ✅

3. Fashion Store Premium - Koleksi Musim Ini
   - Type: Image
   - Status: Active
   - Vendor: Fashion
   - Images: 3
   - PDF: None

4. Beauty Salon Cantik - Perawatan Special
   - Type: Image
   - Status: Active
   - Vendor: Beauty
   - Images: 2
   - PDF: None

5. Cafe Modern - Diskon Member
   - Type: Image
   - Status: Active
   - Vendor: Food
   - Images: 2
   - PDF: None

6. Gym Fitness Pro - Membership Terbaru
   - Type: Image
   - Status: Active
   - Vendor: Fitness
   - Images: 2
   - PDF: None
```

---

## 🎯 Analytics Tracking

Aplikasi track 8 jenis interaksi:

```
1. View        - User melihat ad (tracked saat detail screen load)
2. Click       - User click pada ad
3. Share       - User share via button
4. Favorite    - User like/favorite
5. PDF View    - User view PDF
6. CTA Click   - User click call-to-action
7. Scroll Past - User scroll past ad (future)
8. Download    - User download material (future)
```

**Analytics Display:**
- Total Views
- Total Clicks
- Total Shares
- Total Favorites
- Total PDF Views
- Total Downloads
- Engagement Rate = (clicks + shares + favorites + cta_clicks) / views × 100%
- CTR = clicks / views × 100%

---

## 🎨 UI Components Siap Pakai

### 1. **AdsCarousel** 
Auto-scrolling carousel dengan manual navigation
```dart
AdsCarousel(
  advertisements: ads,
  onAdTap: (adId) { /* navigate */ },
  onFavorite: (adId, isFav) { /* track */ },
  favoriteIds: favorites,
)
```

### 2. **AdCarouselCard**
Single card dalam carousel
```dart
AdCarouselCard(
  advertisement: ad,
  onTap: () { /* tap handler */ },
  onFavorite: () { /* favorite handler */ },
  isFavorite: false,
)
```

### 3. **AdListTile**
List item untuk list view
```dart
AdListTile(
  advertisement: ad,
  onTap: () { /* tap handler */ },
  onFavorite: () { /* favorite handler */ },
  isFavorite: false,
)
```

### 4. **AnalyticsIndicator**
Grid display untuk metrics
```dart
AnalyticsIndicator(
  analytics: adAnalytics,
)
```

---

## 📲 Navigation Routes

```
Main Screen (AdsTabScreen)
├── Carousel Tab
│   ├── Tap Ad → AdDetailScreen
│   ├── Favorite → Track & Update UI
│   └── Toggle View → Switch to List
├── List Tab
│   ├── Tap Ad → AdDetailScreen
│   └── Favorite → Track & Update UI
├── Trending Tab
│   ├── Tap Ad → AdDetailScreen
│   └── Favorite → Track & Update UI
└── Favorites Tab
    ├── Tap Ad → AdDetailScreen
    └── Favorite → Toggle & Update

Detail Screen (AdDetailScreen)
├── Favorite Button → Track & Update
├── PDF Button → Navigate to PdfViewerScreen
├── Share Button → Show Share Dialog
└── CTA Button → Show Snackbar (future: open URL)

PDF Viewer (PdfViewerScreen)
└── Open PDF → Show PDF (future: with pdfrx)
```

---

## 🔄 State Management

Menggunakan **Provider Pattern** dengan ChangeNotifier:

```dart
// AdsProvider
- loadAds()                      // Load semua ads
- searchAds(query)              // Search ads
- filterByCategory(category)    // Filter by category
- resetFilters()                // Reset filters
- getTrendingAds()              // Get trending

// AnalyticsProvider
- trackAdView(adId)             // Track view
- trackAdClick(adId)            // Track click
- trackAdShare(adId)            // Track share
- trackAdFavorite(adId)         // Track favorite
- trackCtaClick(adId)           // Track CTA click
- trackPdfView(adId)            // Track PDF view
- getAdAnalytics(adId)          // Get metrics
```

---

## 🛠️ Services

### AdsService
Mock data service dengan 6 sample ads

### AnalyticsService
Singleton service untuk tracking & metrics calculation

### MediaService
Handle PDF loading (assets & URLs)

---

## 📋 Testing Checklist

Setelah `flutter run`, test ini:

- [ ] **Carousel**
  - [ ] Auto-scroll setiap 5 detik
  - [ ] Manual swipe bekerja
  - [ ] Indicator dots update
  - [ ] Tap indicator dots navigate
  - [ ] Tap ad navigate ke detail

- [ ] **View Toggle**
  - [ ] Carousel view default
  - [ ] Click toggle → List view
  - [ ] List view scroll smooth
  - [ ] Click toggle → Back to carousel

- [ ] **Tabs**
  - [ ] All tab show semua ads
  - [ ] Trending tab show trending ads
  - [ ] Favorites tab empty (jika belum favorite)
  - [ ] Tab swipe smooth

- [ ] **Search**
  - [ ] Type text → filter real-time
  - [ ] Clear text → reset results
  - [ ] Search case-insensitive

- [ ] **Category Filter**
  - [ ] Click category chip → filter
  - [ ] Multiple category work
  - [ ] Reset button clear filters

- [ ] **Detail Screen**
  - [ ] Image gallery swipe
  - [ ] Image indicator update
  - [ ] Vendor info display
  - [ ] Promo code visible
  - [ ] Discount show 50%
  - [ ] Date show correct
  - [ ] Categories chips display
  - [ ] Analytics metrics show

- [ ] **PDF**
  - [ ] Click "Lihat PDF" button
  - [ ] Navigate to PdfViewerScreen
  - [ ] Show PDF loaded
  - [ ] Show file path & size
  - [ ] PDF dari assets load correctly

- [ ] **Share**
  - [ ] Click "Bagikan" button
  - [ ] Show share dialog
  - [ ] Options: WhatsApp, Email, Copy Link

---

## 🎯 Next Steps

### 1. **Run & Test UI**
```bash
flutter run
```

### 2. **Test All Features**
Follow testing checklist above

### 3. **Integrate PDF Viewer** (Optional)
Update PdfViewerScreen dengan pdfrx viewer:
```dart
// Future implementation
PdfViewer(
  controller: PdfViewerController(),
  filePath: pdfFile.path,
)
```

### 4. **Connect Real API**
Replace AdsService.getAllAds() dengan API call

### 5. **Add More Features**
- [ ] Real-time push notifications
- [ ] User authentication
- [ ] Save favorites to local storage (Hive)
- [ ] Advanced analytics (send to backend)
- [ ] Share dengan deep links
- [ ] Wishlist management

---

## 📞 Troubleshooting

### Issue: "assets/pdf/ not found"
**Solution:** Ensure pubspec.yaml has assets section:
```yaml
flutter:
  assets:
    - assets/pdf/
```

### Issue: Carousel not scrolling
**Solution:** Check carousel_slider version in pubspec.yaml

### Issue: PDF not loading
**Solution:** Check PDF path is correct in ads_service.dart

### Issue: Analytics not tracking
**Solution:** Ensure AnalyticsProvider wrapped in MultiProvider

---

## ✅ Completion Status

- ✅ **Models**: Advertisement, Vendor, UserInteraction, AdAnalytics
- ✅ **Services**: AdsService (mock data), AnalyticsService, MediaService
- ✅ **Providers**: AdsProvider, AnalyticsProvider
- ✅ **Screens**: AdsTabScreen, AdDetailScreen, PdfViewerScreen
- ✅ **Widgets**: AdsCarousel, AdCarouselCard, AdListTile, AnalyticsIndicator
- ✅ **Mock Data**: 6 sample ads dengan full metadata
- ✅ **PDF Support**: Load dari assets folder (asset path configured)
- ✅ **Analytics Tracking**: 8 interaction types dengan metrics
- ✅ **UI/UX**: Professional design dengan Material 3

---

**🎉 Aplikasi siap untuk dimulai! Jalankan `flutter run` sekarang!**
