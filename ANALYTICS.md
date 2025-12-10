# Analytics & Tracking Guide

## Overview

Sistem analytics di aplikasi ini dirancang untuk melacak semua interaksi user dengan ads secara detail. Setiap interaksi dicatat dengan timestamp, user ID, dan metadata tambahan untuk keperluan analisis mendalam.

## Tracking System

### UserInteraction Model

Setiap interaksi user direpresentasikan sebagai `UserInteraction` object dengan fields:

```dart
class UserInteraction {
  final String id;                    // Unique ID
  final String adId;                  // Ads ID yang di-interact
  final String userId;                // User ID
  final InteractionType type;         // Jenis interaksi
  final DateTime timestamp;           // Waktu interaksi
  final String? deviceInfo;           // Device information
  final String? ipAddress;            // IP address
  final int? durationInSeconds;       // Duration of interaction
  final Map<String, dynamic>? additionalData; // Extra data
}
```

### Interaction Types

```dart
enum InteractionType {
  view,           // User melihat ads
  click,          // User click/tap ads
  share,          // User share ads
  favorite,       // User add to favorite
  pdf_view,       // User buka PDF
  cta_click,      // User click call-to-action
  scroll_past,    // User scroll past ads
  download,       // User download ads
}
```

## Analytics Service

### Core Tracking Methods

```dart
// Track ad view
Future<void> trackAdView(String adId, String userId)

// Track ad click
Future<void> trackAdClick(String adId, String userId)

// Track ad share
Future<void> trackAdShare(String adId, String userId)

// Track favorite
Future<void> trackAdFavorite(String adId, String userId)

// Track PDF view
Future<void> trackPdfView(String adId, String userId)

// Track CTA click
Future<void> trackCtaClick(String adId, String userId)

// Track download
Future<void> trackDownload(String adId, String userId)
```

### Generic Tracking Method

```dart
Future<void> trackInteraction({
  required String adId,
  required String userId,
  required InteractionType type,
  String? deviceInfo,
  String? ipAddress,
  int? durationInSeconds,
  Map<String, dynamic>? additionalData,
})
```

## Analytics Metrics

### AdAnalytics Model

Aggregate metrics untuk single ads:

```dart
class AdAnalytics {
  final String adId;
  final int totalViews;               // Total views
  final int totalClicks;              // Total clicks
  final int totalShares;              // Total shares
  final int totalFavorites;           // Total favorites
  final int totalPdfViews;            // Total PDF views
  final int totalCtaClicks;           // Total CTA clicks
  final int totalDownloads;           // Total downloads
  final double engagementRate;        // Calculated engagement rate
  final double ctrRate;               // Calculated CTR
  final List<InteractionType> topInteractions; // Top 3 interactions
  final DateTime createdAt;
  final DateTime? updatedAt;
}
```

### Calculated Metrics

#### Engagement Rate (%)
Formula:
```
(totalClicks + totalShares + totalFavorites + totalCtaClicks) / totalViews * 100
```

Interpretation:
- 0% = No engagement
- 1-5% = Low engagement
- 5-10% = Medium engagement
- 10%+ = High engagement

#### Click-Through Rate (CTR) (%)
Formula:
```
totalClicks / totalViews * 100
```

Interpretation:
- <0.5% = Low CTR
- 0.5-2% = Normal CTR
- 2-5% = Good CTR
- 5%+ = Excellent CTR

#### Top Interactions
Top 3 interaction types ranked by frequency.

## Usage in Provider

### AnalyticsProvider

State management untuk analytics:

```dart
class AnalyticsProvider extends ChangeNotifier {
  // Tracking methods
  Future<void> trackAdView(String adId)
  Future<void> trackAdClick(String adId)
  Future<void> trackAdShare(String adId)
  Future<void> trackAdFavorite(String adId)
  Future<void> trackPdfView(String adId)
  Future<void> trackCtaClick(String adId)
  Future<void> trackDownload(String adId)

  // Get analytics
  AdAnalytics getAdAnalytics(String adId)
  List<UserInteraction> getInteractionsByAd(String adId)
  List<UserInteraction> getInteractionsByUser()
  
  // Get specific metrics
  double getEngagementRate(String adId)
  double getCTR(String adId)
}
```

## Implementation Examples

### Track Ad View
```dart
import 'package:provider/provider.dart';

// In a widget
onPageChange: (index) {
  final ad = ads[index];
  context.read<AnalyticsProvider>().trackAdView(ad.id);
}
```

### Track Ad Click
```dart
onTap: () {
  context.read<AnalyticsProvider>().trackAdClick(adId);
  Navigator.of(context).pushNamed('/ad-detail', arguments: ad);
}
```

### Track Favorite
```dart
onFavorite: () {
  setState(() => _isFavorite = !_isFavorite);
  context.read<AnalyticsProvider>().trackAdFavorite(adId);
}
```

### Track Share
```dart
onShare: () {
  context.read<AnalyticsProvider>().trackAdShare(adId);
  // Show share dialog
}
```

### Track PDF View
```dart
onOpenPdf: () {
  context.read<AnalyticsProvider>().trackPdfView(adId);
  _showPdfViewer();
}
```

### Display Analytics
```dart
Consumer<AnalyticsProvider>(
  builder: (context, analyticsProvider, _) {
    final analytics = analyticsProvider.getAdAnalytics(adId);
    
    return Column(
      children: [
        Text('Views: ${analytics.totalViews}'),
        Text('CTR: ${analytics.ctrRate.toStringAsFixed(2)}%'),
        Text('Engagement: ${analytics.engagementRate.toStringAsFixed(2)}%'),
        Text('Top Interaction: ${analytics.topInteractions.first}'),
      ],
    );
  },
)
```

## User ID Management

### Auto-generated User ID
```dart
String _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
```

### Custom User ID
```dart
// Set custom user ID
context.read<AnalyticsProvider>().setUserId('user_123');
```

### Get Current User ID
```dart
String userId = context.read<AnalyticsProvider>().userId;
```

## Data Persistence

### Current Implementation
- In-memory storage (List<UserInteraction>)
- Data hilang saat app restart

### For Production
Implementasi dengan:
1. **Local Database** (Hive, SQLite)
```dart
// Save to local DB
await _saveInteractionToDb(interaction);
```

2. **Remote Server**
```dart
// Send to analytics server
await http.post(
  Uri.parse('https://api.example.com/track'),
  body: jsonEncode(interaction.toJson()),
);
```

3. **Batch Sync**
```dart
// Periodically sync local data to server
Timer.periodic(Duration(minutes: 5), (_) {
  _syncLocalInteractionsToServer();
});
```

## Advanced Features

### User Behavior Analysis

Track view duration:
```dart
final startTime = DateTime.now();

// ... user viewing ad ...

final duration = DateTime.now().difference(startTime).inSeconds;
await analyticsService.trackInteraction(
  adId: adId,
  userId: userId,
  type: InteractionType.view,
  durationInSeconds: duration,
);
```

### Device Tracking

```dart
final deviceInfo = await Device.deviceInfo; // Pseudo code
await analyticsService.trackInteraction(
  adId: adId,
  userId: userId,
  type: InteractionType.view,
  deviceInfo: 'iPhone 14 Pro - iOS 17',
);
```

### Additional Metadata

```dart
await analyticsService.trackInteraction(
  adId: adId,
  userId: userId,
  type: InteractionType.click,
  additionalData: {
    'scrollPosition': 0.5,
    'viewportSize': '1080x2340',
    'referrer': 'carousel',
  },
);
```

## Reporting & Export

### Get Interactions for Analysis

```dart
// Get all interactions for specific ad
List<UserInteraction> interactions = 
  analyticsService.getInteractionsByAd(adId);

// Get all interactions by user
List<UserInteraction> userInteractions = 
  analyticsService.getInteractionsByUser(userId);

// Export as JSON for analysis
final json = interactions
  .map((i) => i.toJson())
  .toList();
```

### Generate Reports

```dart
// Get analytics for date range
List<Advertisement> ads = // ... fetch ads
Map<String, AdAnalytics> report = {
  for (var ad in ads) ad.id: analyticsService.getAdAnalytics(ad.id),
};

// Export report
final reportJson = jsonEncode(
  report.map((id, analytics) => 
    MapEntry(id, analytics.toJson())
  ),
);
```

## Best Practices

1. **Track Immediately**
   - Track interactions as soon as they happen
   - Don't wait for network response

2. **Set Meaningful User IDs**
   - Use consistent user IDs across sessions
   - Link with your user authentication system

3. **Include Context**
   - Add device info for device analysis
   - Include referrer for traffic source tracking
   - Add duration for engagement analysis

4. **Batch Processing**
   - Send interactions in batches to server
   - Reduce network overhead
   - Implement offline queue

5. **Privacy Compliance**
   - Don't track sensitive personal data
   - Follow GDPR, CCPA guidelines
   - Get user consent for tracking

6. **Monitor Performance**
   - Track analytics service performance
   - Monitor memory usage for large datasets
   - Implement cleanup/archival

## Future Enhancements

- [ ] Real-time analytics dashboard
- [ ] A/B testing framework
- [ ] Predictive analytics
- [ ] Cohort analysis
- [ ] Funnel analysis
- [ ] Heatmaps & session replay
- [ ] Custom events
- [ ] Segment tracking
- [ ] Attribution modeling
- [ ] Real-time alerts & anomaly detection
