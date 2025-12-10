import '../models/index.dart';

/// Mock service untuk data ads - nanti bisa diganti dengan API real
class AdsService {
  static final AdsService _instance = AdsService._internal();

  factory AdsService() {
    return _instance;
  }

  AdsService._internal();

  /// Get semua ads
  Future<List<Advertisement>> getAllAds() async {
    // Simulasi delay network
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Advertisement(
        id: '1',
        vendorId: 'v1',
        vendorName: 'Restaurant Paradise',
        vendorLogo: 'https://via.placeholder.com/100?text=Paradise',
        title: 'Diskon 50% untuk Menu Spesial',
        description: 'Nikmati diskon besar-besaran untuk semua menu pilihan',
        longDescription:
            'Dapatkan diskon hingga 50% untuk semua menu spesial kami. Promo berlaku untuk dine-in, takeout, dan delivery. Kode promo: PARADISE50',
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Resto+Promo+1',
          'https://via.placeholder.com/400x300?text=Resto+Promo+2',
        ],
        mediaType: AdMediaType.image,
        status: AdStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        discountPercentage: 50,
        promoCode: 'PARADISE50',
        callToActionText: 'Pesan Sekarang',
        callToActionUrl: 'https://example.com/paradise',
        categories: ['Restoran', 'Food', 'Diskon'],
        createdAt: DateTime.now(),
        viewCount: 1250,
        clickCount: 180,
        shareCount: 45,
      ),
      Advertisement(
        id: '2',
        vendorId: 'v2',
        vendorName: 'Luxury Hotel Bintang Lima',
        vendorLogo: 'https://via.placeholder.com/100?text=Hotel',
        title: 'Paket Honeymoon Eksklusif',
        description: 'Menginap di hotel bintang 5 dengan harga spesial',
        longDescription:
            'Nikmati liburan impian Anda dengan paket honeymoon eksklusif kami. Termasuk spa gratis, sarapan mewah, dan pemandangan sunset yang menakjubkan.',
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Hotel+1',
          'https://via.placeholder.com/400x300?text=Hotel+2',
        ],
        pdfUrl: 'assets/pdf/Solution Package 2025 Updated For Partner.pdf',
        mediaType: AdMediaType.pdf,
        status: AdStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 60)),
        discountPercentage: 30,
        promoCode: 'HONEYMOON30',
        callToActionText: 'Lihat Paket',
        categories: ['Hotel', 'Liburan', 'Honeymoon'],
        createdAt: DateTime.now(),
        viewCount: 890,
        clickCount: 156,
        shareCount: 67,
      ),
      Advertisement(
        id: '3',
        vendorId: 'v3',
        vendorName: 'Fashion Store Premium',
        vendorLogo: 'https://via.placeholder.com/100?text=Fashion',
        title: 'Koleksi Musim Ini - Diskon Hingga 70%',
        description: 'Fashion terkini dengan harga terbaik',
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Fashion+1',
          'https://via.placeholder.com/400x300?text=Fashion+2',
          'https://via.placeholder.com/400x300?text=Fashion+3',
        ],
        mediaType: AdMediaType.image,
        status: AdStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 45)),
        discountPercentage: 70,
        promoCode: 'FASHION70',
        callToActionText: 'Belanja Sekarang',
        callToActionUrl: 'https://example.com/fashion',
        categories: ['Fashion', 'Pakaian', 'Diskon'],
        createdAt: DateTime.now(),
        viewCount: 2100,
        clickCount: 420,
        shareCount: 180,
      ),
      Advertisement(
        id: '4',
        vendorId: 'v1',
        vendorName: 'Restaurant Paradise',
        vendorLogo: 'https://via.placeholder.com/100?text=Paradise',
        title: 'Menu Baru - Pizza Italia Authentik',
        description: 'Rasakan cita rasa Italia yang sesungguhnya',
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Pizza+1',
          'https://via.placeholder.com/400x300?text=Pizza+2',
        ],
        mediaType: AdMediaType.image,
        status: AdStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        discountPercentage: 20,
        promoCode: 'PIZZA20',
        callToActionText: 'Pesan Sekarang',
        categories: ['Restoran', 'Food', 'Italia'],
        createdAt: DateTime.now(),
        viewCount: 650,
        clickCount: 95,
        shareCount: 32,
      ),
      Advertisement(
        id: '5',
        vendorId: 'v2',
        vendorName: 'Luxury Hotel Bintang Lima',
        vendorLogo: 'https://via.placeholder.com/100?text=Hotel',
        title: 'Weekend Getaway - Hanya 2 Juta',
        description: 'Escape dari rutinitas dengan harga terjangkau',
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Weekend+1',
          'https://via.placeholder.com/400x300?text=Weekend+2',
        ],
        mediaType: AdMediaType.image,
        status: AdStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 20)),
        discountPercentage: 45,
        promoCode: 'WEEKEND45',
        callToActionText: 'Booking',
        categories: ['Hotel', 'Liburan', 'Weekend'],
        createdAt: DateTime.now(),
        viewCount: 1500,
        clickCount: 225,
        shareCount: 89,
      ),
      Advertisement(
        id: '6',
        vendorId: 'v4',
        vendorName: 'Beauty Salon Mewah',
        vendorLogo: 'https://via.placeholder.com/100?text=Beauty',
        title: 'Perawatan Wajah Terbaru - Korean Beauty',
        description: 'Hadirkan kecantikan Korea ke wajah Anda',
        imageUrls: [
          'https://via.placeholder.com/400x300?text=Beauty+1',
          'https://via.placeholder.com/400x300?text=Beauty+2',
        ],
        mediaType: AdMediaType.image,
        status: AdStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 40)),
        discountPercentage: 35,
        promoCode: 'KOREAN35',
        callToActionText: 'Booking Gratis',
        categories: ['Kecantikan', 'Perawatan', 'Salon'],
        createdAt: DateTime.now(),
        viewCount: 920,
        clickCount: 138,
        shareCount: 54,
      ),
    ];
  }

  /// Get ads by vendor
  Future<List<Advertisement>> getAdsByVendor(String vendorId) async {
    final allAds = await getAllAds();
    return allAds.where((ad) => ad.vendorId == vendorId).toList();
  }

  /// Get ads by category
  Future<List<Advertisement>> getAdsByCategory(String category) async {
    final allAds = await getAllAds();
    return allAds
        .where((ad) => ad.categories.contains(category))
        .toList();
  }

  /// Search ads
  Future<List<Advertisement>> searchAds(String query) async {
    final allAds = await getAllAds();
    final lowerQuery = query.toLowerCase();

    return allAds
        .where((ad) =>
            ad.title.toLowerCase().contains(lowerQuery) ||
            ad.description.toLowerCase().contains(lowerQuery) ||
            ad.vendorName.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Get trending ads
  Future<List<Advertisement>> getTrendingAds({int limit = 10}) async {
    final allAds = await getAllAds();
    allAds.sort((a, b) => b.engagementRate.compareTo(a.engagementRate));
    return allAds.take(limit).toList();
  }

  /// Get ads detail by id
  Future<Advertisement?> getAdById(String adId) async {
    final allAds = await getAllAds();
    try {
      return allAds.firstWhere((ad) => ad.id == adId);
    } catch (e) {
      return null;
    }
  }

  /// Update ad favorite status
  Future<Advertisement?> updateAdFavorite(String adId, bool isFavorite) async {
    final ad = await getAdById(adId);
    if (ad != null) {
      return ad.copyWith(isFavorite: isFavorite);
    }
    return null;
  }
}
