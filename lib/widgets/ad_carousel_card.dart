import 'package:flutter/material.dart';
import '../models/index.dart';

/// Professional Enterprise Ad Carousel Card
class AdCarouselCard extends StatelessWidget {
  final Advertisement advertisement;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const AdCarouselCard({
    Key? key,
    required this.advertisement,
    required this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.height < screenSize.width;
    final cardHeight = isLandscape ? screenSize.height * 0.7 : screenSize.height * 0.55;
    
    // Responsive sizing
    final titleFontSize = isLandscape ? 18.0 : 26.0;
    final descriptionFontSize = isLandscape ? 12.0 : 15.0;
    final discountFontSize = isLandscape ? 12.0 : 16.0;
    final badgePaddingH = isLandscape ? 10.0 : 14.0;
    final badgePaddingV = isLandscape ? 6.0 : 10.0;
    final contentPadding = isLandscape ? 16.0 : 24.0;
    final favoriteIconSize = isLandscape ? 22.0 : 26.0;
    final favoriteButtonPadding = isLandscape ? 10.0 : 14.0;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              /// Background Image with effect
              _buildBackgroundImage(),

              /// Subtle gradient overlay - Foto tetap dominan
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.08),
                      Colors.black.withOpacity(0.35),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),

              /// Content - Responsive
              Padding(
                padding: EdgeInsets.all(contentPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top right - Small favorite & discount badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Small discount badge - Top left corner (minimal)
                        if (advertisement.discountPercentage != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: badgePaddingH,
                              vertical: badgePaddingV,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade500.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'HEMAT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: isLandscape ? 7.0 : 10.0,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  '-${advertisement.discountPercentage}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: discountFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        /// Favorite button - Subtle
                        GestureDetector(
                          onTap: onFavorite,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(favoriteButtonPadding),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red.shade300 : Colors.white,
                              size: favoriteIconSize,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Bottom - Title & Description Only
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Title
                        Text(
                          advertisement.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                            height: 1.15,
                          ),
                          maxLines: isLandscape ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isLandscape ? 4 : 10),

                        /// Description
                        Text(
                          advertisement.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: descriptionFontSize,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                          maxLines: isLandscape ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    final imageUrl = (advertisement.imageUrls.isNotEmpty &&
            advertisement.imageUrls[0].isNotEmpty)
        ? advertisement.imageUrls[0]
        : null;

    if (imageUrl == null) {
      return Container(color: Colors.grey.shade300);
    }

    return Positioned.fill(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey.shade300,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.broken_image, size: 40, color: Colors.black26),
            ),
          );
        },
      ),
    );
  }
}
