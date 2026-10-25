import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/game_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/app_image.dart';
import '../widgets/game_list_card.dart';
import 'game_detail_screen.dart';

/// Halaman Daftar Game (List Screen).
///
/// Menampilkan seluruh game dalam bentuk ListView vertikal. Halaman ini
/// juga dapat dipakai untuk menampilkan hasil filter kategori dengan
/// mengirim [categoryId].
class GameListScreen extends StatefulWidget {
  final GameCatalog catalog;
  final String? categoryId;
  final String title;

  const GameListScreen({
    super.key,
    required this.catalog,
    this.categoryId,
    this.title = 'Daftar game',
  });

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  late String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.categoryId;
  }

  List<Game> get _games => _selectedCategory == null
      ? widget.catalog.games
      : widget.catalog.byCategory(_selectedCategory!);

  void _openDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final games = _games;
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: _AppBarAvatar(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: games.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada game pada kategori ini.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return GameListCard(
                        game: game,
                        onTap: () => _openDetail(game),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final options = <MapEntry<String?, String>>[
      const MapEntry(null, 'Semua'),
      ...widget.catalog.categories.map((c) => MapEntry(c.id, c.name)),
    ];

    return Container(
      color: AppColors.cream,
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: options.map((entry) {
          final selected = _selectedCategory == entry.key;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: selected,
              onSelected: (_) =>
                  setState(() => _selectedCategory = entry.key),
              showCheckmark: false,
              selectedColor: AppColors.accent,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: selected ? Colors.white : AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selected ? AppColors.accent : Colors.black12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AppBarAvatar extends StatelessWidget {
  const _AppBarAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accent, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: const AppImage(
        url: 'https://picsum.photos/seed/gameravatar/120/120',
        fallbackIcon: Icons.person_rounded,
      ),
    );
  }
}
