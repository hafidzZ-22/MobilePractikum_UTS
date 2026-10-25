import 'package:flutter/material.dart';

import 'screens/main_shell.dart';
import 'services/game_repository.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GamerZoneApp());
}

/// Aplikasi katalog game "GamerZone".
///
/// Alur: memuat data katalog dari JSON lokal, lalu menampilkan [MainShell].
class GamerZoneApp extends StatelessWidget {
  const GamerZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamerZone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _CatalogLoader(),
    );
  }
}

class _CatalogLoader extends StatefulWidget {
  const _CatalogLoader();

  @override
  State<_CatalogLoader> createState() => _CatalogLoaderState();
}

class _CatalogLoaderState extends State<_CatalogLoader> {
  late final Future<GameCatalog> _future;

  @override
  void initState() {
    super.initState();
    _future = GameRepository().fetchCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GameCatalog>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _SplashScreen();
        }
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.cream,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded,
                        color: AppColors.accent, size: 52),
                    const SizedBox(height: 12),
                    const Text('Gagal memuat data game.'),
                    const SizedBox(height: 6),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return MainShell(catalog: snapshot.data!);
      },
    );
  }
}

/// Tampilan splash singkat saat data sedang dimuat.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.darkSlate,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sports_esports_rounded,
                color: AppColors.accent, size: 64),
            SizedBox(height: 16),
            Text(
              'GamerZone',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
