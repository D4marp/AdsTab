import 'package:flutter/material.dart';
import '../models/index.dart';

/// Analytics indicator untuk display metrics
class AnalyticsIndicator extends StatelessWidget {
  final AdAnalytics analytics;
  final double height;

  const AnalyticsIndicator({
    Key? key,
    required this.analytics,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          /// Title
          const Text(
            'Data Interaksi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          /// Metrics grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _MetricCard(
                icon: Icons.visibility,
                label: 'Views',
                value: analytics.totalViews.toString(),
                color: Colors.blue,
              ),
              _MetricCard(
                icon: Icons.touch_app,
                label: 'Clicks',
                value: analytics.totalClicks.toString(),
                color: Colors.green,
              ),
              _MetricCard(
                icon: Icons.share,
                label: 'Shares',
                value: analytics.totalShares.toString(),
                color: Colors.orange,
              ),
              _MetricCard(
                icon: Icons.favorite,
                label: 'Favorites',
                value: analytics.totalFavorites.toString(),
                color: Colors.red,
              ),
              _MetricCard(
                icon: Icons.picture_as_pdf,
                label: 'PDF Views',
                value: analytics.totalPdfViews.toString(),
                color: Colors.purple,
              ),
              _MetricCard(
                icon: Icons.download,
                label: 'Downloads',
                value: analytics.totalDownloads.toString(),
                color: Colors.teal,
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Engagement metrics
          _EngagementBar(
            label: 'Engagement Rate',
            value: analytics.engagementRate,
            percentage: true,
          ),
          const SizedBox(height: 12),
          _EngagementBar(
            label: 'Click-Through Rate',
            value: analytics.ctrRate,
            percentage: true,
          ),
        ],
      ),
    );
  }
}

/// Metric card untuk display single metric
class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Engagement bar untuk display percentage metrics
class _EngagementBar extends StatelessWidget {
  final String label;
  final double value;
  final bool percentage;

  const _EngagementBar({
    required this.label,
    required this.value,
    this.percentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = percentage ? '${value.toStringAsFixed(1)}%' : value.toString();
    final clampedValue = (value / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              displayValue,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: clampedValue,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              clampedValue > 0.7 ? Colors.green : (clampedValue > 0.4 ? Colors.orange : Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
