import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/index.dart';
import 'ad_carousel_card.dart';

/// Carousel widget untuk display ads
class AdsCarousel extends StatefulWidget {
  final List<Advertisement> advertisements;
  final Function(String) onAdTap;
  final Function(String, bool)? onFavorite;
  final Set<String> favoriteIds;

  const AdsCarousel({
    Key? key,
    required this.advertisements,
    required this.onAdTap,
    this.onFavorite,
    this.favoriteIds = const {},
  }) : super(key: key);

  @override
  State<AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.advertisements.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada ads yang tersedia',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Column(
      children: [
        /// Carousel
        CarouselSlider.builder(
          itemCount: widget.advertisements.length,
          itemBuilder: (context, index, realIndex) {
            final ad = widget.advertisements[index];
            return AdCarouselCard(
              advertisement: ad,
              onTap: () => widget.onAdTap(ad.id),
              onFavorite: () {
                widget.onFavorite?.call(ad.id, !widget.favoriteIds.contains(ad.id));
              },
              isFavorite: widget.favoriteIds.contains(ad.id),
            );
          },
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            pauseAutoPlayOnManualNavigate: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 16),

        /// Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.advertisements.length,
            (index) => GestureDetector(
              onTap: () {},
              child: Container(
                width: _currentIndex == index ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
