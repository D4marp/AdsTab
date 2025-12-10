import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Service untuk menangani PDF dan media files
class MediaService {
  static final MediaService _instance = MediaService._internal();

  factory MediaService() {
    return _instance;
  }

  MediaService._internal();

  /// Load PDF dari assets
  /// Contoh: 'assets/pdf/brochure.pdf'
  Future<File?> loadPdfFromAssets(String assetPath) async {
    try {
      final bytes = await rootBundle.load(assetPath);
      final dir = await getTemporaryDirectory();
      final fileName = assetPath.split('/').last;
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      return file;
    } catch (e) {
      print('Error loading PDF from assets: $e');
      return null;
    }
  }

  /// Download PDF dari URL
  Future<File?> downloadPdf(String pdfUrl, String fileName) async {
    try {
      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
      return null;
    } catch (e) {
      print('Error downloading PDF: $e');
      return null;
    }
  }

  /// Get PDF file - dari asset atau download dari URL
  Future<File?> getPdfFile(String pdfUrl) async {
    try {
      // Jika dimulai dengan 'assets/', load dari assets
      if (pdfUrl.startsWith('assets/')) {
        return await loadPdfFromAssets(pdfUrl);
      }
      
      // Jika URL, download dari internet
      final fileName = pdfUrl.split('/').last;
      return await downloadPdf(pdfUrl, fileName);
    } catch (e) {
      print('Error getting PDF file: $e');
      return null;
    }
  }

  /// Check apakah URL adalah asset
  bool isAssetPath(String path) {
    return path.startsWith('assets/');
  }
}
