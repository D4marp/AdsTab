# Application Flow & Architecture Diagrams

## 1. App Navigation Flow

```
┌─────────────────────────────────────────────┐
│         MyApp (main.dart)                   │
│  - MultiProvider setup                      │
│  - Route configuration                      │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  AdsTabScreen        │
        │  (Main/Home)         │
        │  - Carousel View     │
        │  - List View         │
        │  - Categories Filter │
        │  - Search Bar        │
        └──────────┬───────────┘
                   │
         ┌─────────┴──────────┐
         │ 3 Tabs:            │
         │ All, Trending,     │
         │ Favorites          │
         └─────────┬──────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  AdDetailScreen      │
        │  (Detail Page)       │
        │  - Image Gallery     │
        │  - Full Info         │
        │  - Promo Code        │
        │  - Analytics         │
        │  - Action Buttons    │
        └──────────────────────┘
```

## 2. State Management Architecture

```
┌────────────────────────────────────────────────────────┐
│              MultiProvider (main.dart)                 │
├────────────────────────────────────────────────────────┤
│                                                        │
│  ┌──────────────────────┐   ┌──────────────────────┐  │
│  │  AdsProvider         │   │ AnalyticsProvider    │  │
│  ├──────────────────────┤   ├──────────────────────┤  │
│  │ - allAds             │   │ - userId             │  │
│  │ - filteredAds        │   │ - adAnalytics (map)  │  │
│  │ - searchQuery        │   │ - isLoading          │  │
│  │ - selectedCategory   │   │ - error              │  │
│  │ - isLoading          │   │                      │  │
│  │ - error              │   │ Methods:             │  │
│  │                      │   │ - trackAdView()      │  │
│  │ Methods:             │   │ - trackAdClick()     │  │
│  │ - loadAds()          │   │ - trackAdShare()     │  │
│  │ - searchAds()        │   │ - trackAdFavorite()  │  │
│  │ - filterByCategory() │   │ - trackPdfView()     │  │
│  │ - resetFilters()     │   │ - trackCtaClick()    │  │
│  │ - getTrendingAds()   │   │ - trackDownload()    │  │
│  │ - trackAdView()      │   │ - getAdAnalytics()   │  │
│  └──────────────────────┘   └──────────────────────┘  │
│         │                             │                │
│         └─────────────┬───────────────┘                │
│                       │                                │
└───────────────────────┼────────────────────────────────┘
                        │
                        ▼
            ┌────────────────────────┐
            │  Services              │
            ├────────────────────────┤
            │ - AdsService           │
            │ - AnalyticsService     │
            │ - MediaService         │
            └────────────────────────┘
```

## 3. Data Model Relationships

```
┌──────────────────────────────────────────────────────────┐
│                     Vendor                               │
│  ┌────────────────────────────────────────────────────┐  │
│  │ - id, name, description, logo                      │  │
│  │ - website, phone, address                          │  │
│  │ - rating, totalReviews                             │  │
│  │ - categories, createdAt, isActive                  │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────┬───────────────────────────────────┘
                       │ (1 to Many)
                       │
                       ▼
┌──────────────────────────────────────────────────────────┐
│                 Advertisement                            │
│  ┌────────────────────────────────────────────────────┐  │
│  │ - id, vendorId, vendorName, vendorLogo             │  │
│  │ - title, description, longDescription              │  │
│  │ - imageUrls, pdfUrl, mediaType                      │  │
│  │ - status, startDate, endDate                        │  │
│  │ - discountPercentage, promoCode                     │  │
│  │ - callToActionText, callToActionUrl                │  │
│  │ - categories                                        │  │
│  │ - viewCount, clickCount, shareCount                 │  │
│  │ - createdAt, updatedAt, isFavorite                  │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────┬───────────────────────────────────┘
                       │ (1 to Many)
                       │
                       ▼
┌──────────────────────────────────────────────────────────┐
│                 UserInteraction                          │
│  ┌────────────────────────────────────────────────────┐  │
│  │ - id, adId, userId                                 │  │
│  │ - type (InteractionType enum)                       │  │
│  │ - timestamp, deviceInfo, ipAddress                  │  │
│  │ - durationInSeconds, additionalData                 │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│              AdAnalytics (Computed)                      │
│  ┌────────────────────────────────────────────────────┐  │
│  │ - adId                                              │  │
│  │ - totalViews, totalClicks, totalShares             │  │
│  │ - totalFavorites, totalPdfViews                     │  │
│  │ - totalCtaClicks, totalDownloads                    │  │
│  │ - engagementRate, ctrRate                           │  │
│  │ - topInteractions                                   │  │
│  │ - createdAt, updatedAt                              │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘
```

## 4. Analytics Tracking Flow

```
User Interaction
    │
    ├─ View Ad
    ├─ Click Ad
    ├─ Share Ad
    ├─ Favorite Ad
    ├─ Open PDF
    ├─ Click CTA
    └─ Download
    │
    ▼
┌─────────────────────────────┐
│  AnalyticsProvider          │
│  .trackAdView(adId)         │
│  .trackAdClick(adId)        │
│  ... etc                    │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│  AnalyticsService           │
│  trackInteraction()         │
│  - Create UserInteraction   │
│  - Store in memory          │
│  - (Optional) Send to API   │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│  Calculate Metrics          │
│  - getAdAnalytics()         │
│  - Aggregate interactions   │
│  - Calculate rates          │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│  Update UI                  │
│  - AnalyticsIndicator       │
│  - Display metrics          │
│  - Show charts              │
└─────────────────────────────┘
```

## 5. Screen Hierarchy

```
┌─────────────────────────────────────────────────────┐
│              MaterialApp                            │
│  - Theme configuration                              │
│  - Route management                                 │
└─────────────────────┬───────────────────────────────┘
                      │
                      ▼
        ┌──────────────────────────────┐
        │      AdsTabScreen            │
        │    (Main/Home Screen)        │
        └──────────────┬───────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
    ┌────────┐    ┌────────┐    ┌──────────┐
    │  All   │    │Trending│    │Favorites │
    │  Ads   │    │  Ads   │    │   Tab    │
    └────────┘    └────────┘    └──────────┘
        │              │              │
        └──────────────┼──────────────┘
                       │
                       ▼
        ┌──────────────────────────────┐
        │     AdDetailScreen           │
        │   (Detail/Full Page)         │
        └──────────────────────────────┘
```

## 6. Widget Component Tree

```
AdsTabScreen
│
├─ AppBar
│  └─ Actions (toggle view)
│
├─ TabBar
│  ├─ Tab: All
│  ├─ Tab: Trending
│  └─ Tab: Favorites
│
└─ TabBarView
   ├─ All Ads Tab
   │  ├─ AdsCarousel (if carousel view)
   │  │  └─ AdCarouselCard (multiple)
   │  │     ├─ Image
   │  │     ├─ Vendor Info
   │  │     ├─ Title & Description
   │  │     └─ Favorite Button
   │  │
   │  └─ ListView (if list view)
   │     └─ AdListTile (multiple)
   │        ├─ Image Thumbnail
   │        ├─ Title & Description
   │        ├─ Metrics
   │        └─ Favorite Button
   │
   ├─ Trending Tab (similar structure)
   │
   └─ Favorites Tab (similar structure)


AdDetailScreen
│
├─ AppBar
│  └─ Favorite Button
│
└─ SingleChildScrollView
   ├─ Image Carousel (PageView)
   │  ├─ Image (multiple)
   │  └─ Indicator Dots
   │
   ├─ Vendor Info
   │  ├─ Avatar
   │  ├─ Name
   │  └─ Categories
   │
   ├─ Title & Description
   ├─ Discount Badge
   ├─ Categories (Chips)
   ├─ Date Info
   │
   ├─ AnalyticsIndicator
   │  ├─ Metrics Grid
   │  │  ├─ Views
   │  │  ├─ Clicks
   │  │  ├─ Shares
   │  │  ├─ Favorites
   │  │  ├─ PDF Views
   │  │  └─ Downloads
   │  │
   │  ├─ Engagement Rate Bar
   │  └─ CTR Rate Bar
   │
   └─ Action Buttons
      ├─ CTA Button
      ├─ PDF Button
      └─ Share Button
```

## 7. Service Layer Architecture

```
┌────────────────────────────────────┐
│      AdsProvider                   │
│  (State Management Layer)          │
└────────────────┬───────────────────┘
                 │
                 ▼
┌────────────────────────────────────┐
│      AdsService                    │
│  - getAllAds()                     │
│  - getAdsByVendor()                │
│  - getAdsByCategory()              │
│  - searchAds()                     │
│  - getTrendingAds()                │
│  - getAdById()                     │
└────────────────────────────────────┘


┌────────────────────────────────────┐
│    AnalyticsProvider               │
│  (Analytics State Management)      │
└────────────────┬───────────────────┘
                 │
                 ▼
┌────────────────────────────────────┐
│    AnalyticsService                │
│  - trackInteraction()              │
│  - trackAdView/Click/Share...      │
│  - getAdAnalytics()                │
│  - getInteractionsByAd()           │
│  - getInteractionsByUser()         │
└────────────────────────────────────┘


┌────────────────────────────────────┐
│      MediaService                  │
│  - downloadFile()                  │
│  - isFileExists()                  │
│  - getLocalFilePath()              │
│  - deleteFile()                    │
│  - getFileSize()                   │
└────────────────────────────────────┘
```

## 8. Data Flow: Ad View & Analytics

```
1. User opens app
   │
   ▼
2. AdsTabScreen loads
   │
   ▼
3. AdsProvider.loadAds()
   │
   ▼
4. AdsService.getAllAds() [mock data]
   │
   ▼
5. Display ads in Carousel/List
   │
   ▼
6. User taps on carousel
   │
   ▼
7. AnalyticsProvider.trackAdView(adId)
   │
   ▼
8. AnalyticsService.trackInteraction(...)
   │
   ├─ Create UserInteraction object
   ├─ Add to interactions list
   └─ Update interaction counts
   │
   ▼
9. Navigate to AdDetailScreen
   │
   ▼
10. Display detailed ad info
    │
    ▼
11. AnalyticsProvider.getAdAnalytics(adId)
    │
    ▼
12. Calculate & display metrics
    │
    ├─ Total Views/Clicks/Shares
    ├─ Engagement Rate
    ├─ CTR Rate
    └─ Top Interactions
    │
    ▼
13. AnalyticsIndicator displays metrics
```

---

**Diagrams created with ASCII art for documentation purposes.**
