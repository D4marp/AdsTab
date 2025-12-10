/// Model untuk Vendor (Restoran, Hotel, Toko, dll)
class Vendor {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final String? website;
  final String? phoneNumber;
  final String? address;
  final double? rating;
  final int? totalReviews;
  final List<String> categories;
  final DateTime createdAt;
  final bool isActive;

  Vendor({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    this.website,
    this.phoneNumber,
    this.address,
    this.rating,
    this.totalReviews,
    required this.categories,
    required this.createdAt,
    this.isActive = true,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      logoUrl: json['logoUrl'] as String,
      website: json['website'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      totalReviews: json['totalReviews'] as int?,
      categories: List<String>.from(json['categories'] as List? ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logoUrl': logoUrl,
      'website': website,
      'phoneNumber': phoneNumber,
      'address': address,
      'rating': rating,
      'totalReviews': totalReviews,
      'categories': categories,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}
