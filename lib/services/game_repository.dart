import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/game.dart';

/// Sumber data aplikasi.
///
/// Saat ini data dibaca dari file JSON lokal (`assets/data/games.json`).
/// Pada pengembangan selanjutnya, method [fetchGames] cukup diganti
/// dengan pemanggilan HTTP ke REST API tanpa mengubah halaman UI.
class GameRepository {
  static const String _assetPath = 'assets/data/games.json';

  Future<GameCatalog> fetchCatalog() async {
    final raw = await rootBundle.loadString(_assetPath);
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;

    final categories = (json['categories'] as List<dynamic>? ?? [])
        .map((e) => GameCategory.fromJson(e as Map<String, dynamic>))
        .toList();

    final games = (json['games'] as List<dynamic>? ?? [])
        .map((e) => Game.fromJson(e as Map<String, dynamic>))
        .toList();

    return GameCatalog(
      appName: json['appName'] as String? ?? 'GamerZone',
      tagline: json['tagline'] as String? ?? '',
      categories: categories,
      games: games,
    );
  }

  /// Simulasi pemanggilan API di masa depan.
  ///
  /// Pada tahap ini cukup memanggil [fetchCatalog].
  Future<GameCatalog> fetchGames() => fetchCatalog();
}

/// Kumpulan data hasil pemuatan katalog.
class GameCatalog {
  final String appName;
  final String tagline;
  final List<GameCategory> categories;
  final List<Game> games;

  const GameCatalog({
    required this.appName,
    required this.tagline,
    required this.categories,
    required this.games,
  });

  List<Game> get popularGames => games.where((g) => g.isPopular).toList();

  List<Game> get latestGames => games.where((g) => g.isLatest).toList();

  List<Game> byCategory(String categoryId) =>
      games.where((g) => g.category == categoryId).toList();

  Game? byId(String id) {
    for (final game in games) {
      if (game.id == id) return game;
    }
    return null;
  }
}
