# Data Models Documentation

## Advertisement Model

Model utama untuk data iklan/promosi.

### Properties

```dart
class Advertisement {
  final String id;                    // ID unik ads
  final String vendorId;              // ID vendor pemilik ads
  final String vendorName;            // Nama vendor
  final String vendorLogo;            // Logo vendor URL
  final String title;                 // Judul promosi
  final String description;           // Deskripsi pendek
  final String? longDescription;      // Deskripsi panjang
  final List<String> imageUrls;       // List image URLs
  final String? pdfUrl;               // URL PDF (optional)
  final AdMediaType mediaType;        // Tipe media (image/pdf/video)
  final AdStatus status;              // Status ads (active/inactive/scheduled/expired)
  final DateTime startDate;           // Tanggal mulai
  final DateTime? endDate;            // Tanggal berakhir
  final int? discountPercentage;      // % diskon (optional)
  final String? promoCode;            // Kode promo (optional)
  final String? callToActionText;     // CTA button text
  final String? callToActionUrl;      // CTA action URL
  final List<String> categories;      // Kategori (Restoran, Hotel, dll)
  final int viewCount;                // Total views
  final int clickCount;               // Total clicks
  final int shareCount;               // Total shares
  final DateTime createdAt;           // Tanggal dibuat
  final DateTime? updatedAt;          // Tanggal update terakhir
  final bool isFavorite;              // Favorite status
}
```

### Computed Properties

```dart
// Cek apakah ads masih aktif berdasarkan date
bool get isCurrentlyActive => ...

// Hitung engagement rate
double get engagementRate => ...
```

### AdMediaType Enum
```dart
enum AdMediaType {
  image,    // Gambar
  pdf,      // PDF file
  video,    // Video (untuk future)
}
```

### AdStatus Enum
```dart
enum AdStatus {
  active,       // Sedang aktif
  inactive,     // Tidak aktif
  scheduled,    // Dijadwalkan
  expired,      // Expired
}
```

---

## UserInteraction Model

Model untuk melacak setiap interaksi user dengan ads.

### Properties

```dart
class UserInteraction {
  final String id;                    // ID unik interaksi
  final String adId;                  // ID ads yang di-interact
  final String userId;                // ID user
  final InteractionType type;         // Tipe interaksi
  final DateTime timestamp;           // Waktu interaksi
  final String? deviceInfo;           // Info device (optional)
  final String? ipAddress;            // IP address (optional)
  final int? durationInSeconds;       // Durasi interaksi (optional)
  final Map<String, dynamic>? additionalData; // Data tambahan
}
```

### InteractionType Enum
```dart
enum InteractionType {
  view,           // View ads
  click,          // Click/tap ads
  share,          // Share ads
  favorite,       // Add to favorite
  pdf_view,       // Open PDF
  cta_click,      // Click call-to-action
  scroll_past,    // Scroll past ads
  download,       // Download ads
}
```

---

## AdAnalytics Model

Model untuk aggregate analytics dari ads tertentu.

### Properties

```dart
class AdAnalytics {
  final String adId;                  // ID ads
  final int totalViews;               // Total views
  final int totalClicks;              // Total clicks
  final int totalShares;              // Total shares
  final int totalFavorites;           // Total favorites
  final int totalPdfViews;            // Total PDF views
  final int totalCtaClicks;           // Total CTA clicks
  final int totalDownloads;           // Total downloads
  final double engagementRate;        // Engagement rate (%)
  final double ctrRate;               // Click-through rate (%)
  final List<InteractionType> topInteractions; // Top 3 interactions
  final DateTime createdAt;           // Created date
  final DateTime? updatedAt;          // Updated date
}
```

### Formulas

**Engagement Rate:**
```
(totalClicks + totalShares + totalFavorites + totalCtaClicks) / totalViews * 100%
```

**Click-Through Rate (CTR):**
```
totalClicks / totalViews * 100%
```

---

## Vendor Model

Model untuk data vendor (Restoran, Hotel, Toko, dll).

### Properties

```dart
class Vendor {
  final String id;                    // ID unik vendor
  final String name;                  // Nama vendor
  final String description;           // Deskripsi vendor
  final String logoUrl;               // Logo URL
  final String? website;              // Website (optional)
  final String? phoneNumber;          // Phone number (optional)
  final String? address;              // Address (optional)
  final double? rating;               // Rating (0-5)
  final int? totalReviews;            // Total reviews count
  final List<String> categories;      // Kategori (Restoran, Hotel, dll)
  final DateTime createdAt;           // Tanggal dibuat
  final bool isActive;                // Active status
}
```

---

## Relationships

```
Vendor (1) ──── (Many) Advertisement
  │
  └── Has multiple ads/promotions
  
Advertisement (1) ──── (Many) UserInteraction
  │
  └── Tracked by multiple user interactions

Advertisement (1) ──── (1) AdAnalytics
  │
  └── Has one analytics record (auto-calculated)
```

---

## JSON Serialization

### Advertisement JSON Example
```json
{
  "id": "1",
  "vendorId": "v1",
  "vendorName": "Restaurant Paradise",
  "vendorLogo": "https://example.com/logo.png",
  "title": "Diskon 50% untuk Menu Spesial",
  "description": "Nikmati diskon besar-besaran",
  "longDescription": "Dapatkan diskon hingga 50%...",
  "imageUrls": ["https://example.com/img1.jpg"],
  "pdfUrl": null,
  "mediaType": "image",
  "status": "active",
  "startDate": "2025-12-10T00:00:00.000Z",
  "endDate": "2026-01-09T00:00:00.000Z",
  "discountPercentage": 50,
  "promoCode": "PARADISE50",
  "callToActionText": "Pesan Sekarang",
  "callToActionUrl": "https://example.com/order",
  "categories": ["Restoran", "Food", "Diskon"],
  "viewCount": 1250,
  "clickCount": 180,
  "shareCount": 45,
  "createdAt": "2025-12-01T10:30:00.000Z",
  "updatedAt": null,
  "isFavorite": false
}
```

### UserInteraction JSON Example
```json
{
  "id": "1702205400000",
  "adId": "1",
  "userId": "user_1702205400000",
  "type": "view",
  "timestamp": "2025-12-10T10:30:00.000Z",
  "deviceInfo": "iPhone 14",
  "ipAddress": "192.168.1.1",
  "durationInSeconds": null,
  "additionalData": null
}
```

---

## Usage Examples

### Create Advertisement
```dart
final ad = Advertisement(
  id: '1',
  vendorId: 'v1',
  vendorName: 'Restaurant Paradise',
  vendorLogo: 'https://example.com/logo.png',
  title: 'Diskon 50%',
  description: 'Nikmati diskon',
  imageUrls: ['https://example.com/img.jpg'],
  mediaType: AdMediaType.image,
  status: AdStatus.active,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 30)),
  discountPercentage: 50,
  promoCode: 'PARADISE50',
  categories: ['Restoran', 'Food'],
  createdAt: DateTime.now(),
);
```

### Track Interaction
```dart
final interaction = UserInteraction(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  adId: '1',
  userId: 'user_123',
  type: InteractionType.view,
  timestamp: DateTime.now(),
);
```

### Copy Advertisement with Changes
```dart
final updatedAd = ad.copyWith(
  viewCount: ad.viewCount + 1,
  isFavorite: true,
);
```
