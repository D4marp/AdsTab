import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/index.dart';
import 'screens/index.dart';
import 'models/advertisement.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdsProvider()),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ],
      child: MaterialApp(
        title: 'Ads & Promotions',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AdsTabScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/ad-detail') {
            final advertisement = settings.arguments as Advertisement?;
            if (advertisement != null) {
              return MaterialPageRoute(
                builder: (context) => AdDetailScreen(
                  advertisement: advertisement,
                ),
              );
            }
          }
          return null;
        },
      ),
    );
  }
}
