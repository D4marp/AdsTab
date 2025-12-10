import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../widgets/index.dart';
import 'pdf_viewer_screen.dart';

/// Halaman detail ads dengan informasi lengkap dan PDF viewer
class AdDetailScreen extends StatefulWidget {
  final Advertisement advertisement;

  const AdDetailScreen({
    Key? key,
    required this.advertisement,
  }) : super(key: key);

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  late PageController _imageController;
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _imageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advertisement Detail'),
        actions: [
          /// Favorite button
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: _toggleFavorite,
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image carousel
            if (widget.advertisement.imageUrls.isNotEmpty)
              _buildImageCarousel(),

            /// Image counter
            if (widget.advertisement.imageUrls.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    '${_currentImageIndex + 1} / ${widget.advertisement.imageUrls.length}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

            /// Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Vendor info
                  _buildVendorInfo(),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  /// Title
                  Text(
                    widget.advertisement.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Discount badge
                  if (widget.advertisement.discountPercentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Diskon ${widget.advertisement.discountPercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  /// Description
                  Text(
                    'Deskripsi',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.advertisement.longDescription ??
                        widget.advertisement.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Promo code
                  if (widget.advertisement.promoCode != null)
                    _buildPromoCodeCard(),

                  const SizedBox(height: 16),

                  /// Categories
                  if (widget.advertisement.categories.isNotEmpty)
                    _buildCategoriesList(),

                  const SizedBox(height: 16),

                  /// Date info
                  _buildDateInfo(),

                  const SizedBox(height: 24),

                  /// Analytics
                  Consumer<AnalyticsProvider>(
                    builder: (context, analyticsProvider, _) {
                      final analytics =
                          analyticsProvider.getAdAnalytics(widget.advertisement.id);
                      return AnalyticsIndicator(analytics: analytics);
                    },
                  ),

                  const SizedBox(height: 24),

                  /// Action buttons
                  _buildActionButtons(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build image carousel
  Widget _buildImageCarousel() {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _imageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: widget.advertisement.imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.advertisement.imageUrls[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        /// Page indicators
        if (widget.advertisement.imageUrls.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.advertisement.imageUrls.length,
                  (index) => Container(
                    width: _currentImageIndex == index ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentImageIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Build vendor info
  Widget _buildVendorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(widget.advertisement.vendorLogo),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.advertisement.vendorName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.advertisement.categories.join(', '),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build promo code card
  Widget _buildPromoCodeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kode Promo',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.advertisement.promoCode!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _copyPromoCode();
                },
                icon: const Icon(Icons.content_copy, size: 16),
                label: const Text('Copy'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build categories list
  Widget _buildCategoriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.advertisement.categories.map((category) {
            return Chip(
              label: Text(category),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Build date info
  Widget _buildDateInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Berlaku dari ${_formatDate(widget.advertisement.startDate)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          if (widget.advertisement.endDate != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.event_busy, size: 16, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Berakhir ${_formatDate(widget.advertisement.endDate!)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Column(
      children: [
        /// Call to action button
        if (widget.advertisement.callToActionText != null)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<AnalyticsProvider>()
                    .trackCtaClick(widget.advertisement.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(widget.advertisement.callToActionText ?? 'Aksi'),
                  ),
                );
              },
              child: Text(widget.advertisement.callToActionText ?? 'Aksi'),
            ),
          ),

        const SizedBox(height: 12),

        /// PDF view button
        if (widget.advertisement.pdfUrl != null)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                context
                    .read<AnalyticsProvider>()
                    .trackPdfView(widget.advertisement.id);
                _showPdfViewer();
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Lihat PDF'),
            ),
          ),

        const SizedBox(height: 12),

        /// Share button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {
              context
                  .read<AnalyticsProvider>()
                  .trackAdShare(widget.advertisement.id);
              _shareAd();
            },
            icon: const Icon(Icons.share),
            label: const Text('Bagikan'),
          ),
        ),
      ],
    );
  }

  /// Format date untuk display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Toggle favorite
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    context
        .read<AnalyticsProvider>()
        .trackAdFavorite(widget.advertisement.id);
  }

  /// Copy promo code
  void _copyPromoCode() {
    // TODO: Implement copy to clipboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.advertisement.promoCode} disalin ke clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show PDF viewer
  void _showPdfViewer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PDF Viewer'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.picture_as_pdf, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'PDF: ${widget.advertisement.title}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.advertisement.pdfUrl ?? 'No PDF',
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _downloadAndOpenPdf();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.download, size: 16),
            label: const Text('Buka PDF'),
          ),
        ],
      ),
    );
  }

  /// Download dan buka PDF
  void _downloadAndOpenPdf() async {
    if (widget.advertisement.pdfUrl == null) return;

    // Navigate ke PDF viewer screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(
          pdfUrl: widget.advertisement.pdfUrl!,
          title: widget.advertisement.title,
        ),
      ),
    );
  }

  /// Share ad
  void _shareAd() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bagikan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('WhatsApp'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dibagikan ke WhatsApp'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text('Email'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dibagikan ke Email'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copy Link'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Link disalin ke clipboard'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
