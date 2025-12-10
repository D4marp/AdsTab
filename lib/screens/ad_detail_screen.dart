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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Detail Penawaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          /// Favorite button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: GestureDetector(
                onTap: _toggleFavorite,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.grey[700],
                    size: 22,
                  ),
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

            /// Content - Elegant white card
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Vendor info - More prominent
                  _buildVendorInfo(),

                  const SizedBox(height: 20),

                  /// Title - Bold & Prominent
                  Text(
                    widget.advertisement.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      letterSpacing: -0.3,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Discount badge - Prominent
                  if (widget.advertisement.discountPercentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade500.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_offer_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Diskon ${widget.advertisement.discountPercentage}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),

                  /// Description
                  Text(
                    'Deskripsi Lengkap',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.advertisement.longDescription ??
                        widget.advertisement.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Promo code
                  if (widget.advertisement.promoCode != null)
                    _buildPromoCodeCard(),

                  if (widget.advertisement.promoCode != null)
                    const SizedBox(height: 24),

                  /// Date info
                  _buildDateInfo(),

                  const SizedBox(height: 28),

                  /// Analytics
                  Consumer<AnalyticsProvider>(
                    builder: (context, analyticsProvider, _) {
                      final analytics =
                          analyticsProvider.getAdAnalytics(widget.advertisement.id);
                      return AnalyticsIndicator(analytics: analytics);
                    },
                  ),

                  const SizedBox(height: 28),

                  /// Action buttons
                  _buildActionButtons(),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build image carousel - Premium design
  Widget _buildImageCarousel() {
    return Stack(
      children: [
        SizedBox(
          height: 320,
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

        /// Page indicators - Modern style
        if (widget.advertisement.imageUrls.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.advertisement.imageUrls.length,
                  (index) => Container(
                    width: _currentImageIndex == index ? 28 : 8,
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

        /// Image counter badge
        if (widget.advertisement.imageUrls.length > 1)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentImageIndex + 1}/${widget.advertisement.imageUrls.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Build vendor info - Elegant design
  Widget _buildVendorInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(widget.advertisement.vendorLogo),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.advertisement.vendorName,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Penawaran Spesial',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.amber.shade200,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kode Promo Eksklusif',
            style: TextStyle(
              fontSize: 11,
              color: Colors.amber.shade700,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.advertisement.promoCode!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Colors.amber,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _copyPromoCode();
                },
                icon: const Icon(Icons.content_copy, size: 18),
                label: const Text('Salin'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade500,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build categories list
  Widget _buildCategoriesList() {
    return const SizedBox.shrink();
  }

  /// Build date info
  Widget _buildDateInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue[200]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 18,
                color: Colors.blue[700],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Berlaku dari ${_formatDate(widget.advertisement.startDate)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ],
          ),
          if (widget.advertisement.endDate != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.event_busy,
                  size: 18,
                  color: Colors.red[700],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Berakhir ${_formatDate(widget.advertisement.endDate!)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[900],
                    ),
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
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<AnalyticsProvider>()
                    .trackCtaClick(widget.advertisement.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(widget.advertisement.callToActionText ?? 'Aksi'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
              child: Text(
                widget.advertisement.callToActionText ?? 'Aksi',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),

        const SizedBox(height: 14),

        /// PDF view button
        if (widget.advertisement.pdfUrl != null)
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton.icon(
              onPressed: () {
                context
                    .read<AnalyticsProvider>()
                    .trackPdfView(widget.advertisement.id);
                _showPdfViewer();
              },
              icon: const Icon(Icons.picture_as_pdf, size: 22),
              label: const Text('Lihat Detail PDF'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

        const SizedBox(height: 14),

        /// Share button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {
              context
                  .read<AnalyticsProvider>()
                  .trackAdShare(widget.advertisement.id);
              _shareAd();
            },
            icon: const Icon(Icons.share_rounded, size: 22),
            label: const Text('Bagikan Penawaran'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey[700],
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Format date untuk display
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
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
