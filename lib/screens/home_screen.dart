import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/game_repository.dart';
import '../theme/app_theme.dart';
import '../utils/category_icons.dart';
import '../widgets/app_image.dart';
import '../widgets/game_list_card.dart';
import '../widgets/popular_banner.dart';
import '../widgets/section_header.dart';
import 'game_detail_screen.dart';
import 'game_list_screen.dart';

/// Halaman Beranda (Home Screen).
///
/// Terdiri dari header gelap berisi salam, avatar, dan search bar;
/// daftar kategori; section "Game Populer"; serta "Game Terbaru".
class HomeScreen extends StatefulWidget {
  final GameCatalog catalog;

  const HomeScreen({super.key, required this.catalog});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Game> get _searchResults {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return widget.catalog.games
        .where((g) =>
            g.title.toLowerCase().contains(q) ||
            g.genre.toLowerCase().contains(q))
        .toList();
  }

  void _openDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
    );
  }

  void _openCategory(GameCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameListScreen(
          catalog: widget.catalog,
          categoryId: category.id,
          title: category.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              children: _query.isNotEmpty
                  ? _buildSearchResults()
                  : _buildMainContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.catalog.tagline,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const _HeaderAvatar(),
                ],
              ),
              const SizedBox(height: 18),
              _buildSearchBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _query = value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Masukkan judul game',
          hintStyle: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 14,
          ),
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.textMuted),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: Material(
              color: AppColors.accent,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pencarian suara (dummy)')),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.mic_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  List<Widget> _buildSearchResults() {
    final results = _searchResults;
    if (results.isEmpty) {
      return [
        const SizedBox(height: 40),
        Center(
          child: Column(
            children: [
              Icon(Icons.search_off_rounded,
                  size: 56, color: AppColors.textMuted.withValues(alpha: 0.6)),
              const SizedBox(height: 12),
              Text(
                'Game "$_query" tidak ditemukan',
                style: const TextStyle(color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ];
    }
    return [
      SectionHeader(title: 'Hasil Pencarian (${results.length})'),
      ...results.map(
        (game) => GameListCard(game: game, onTap: () => _openDetail(game)),
      ),
    ];
  }

  List<Widget> _buildMainContent() {
    return [
      // Kategori
      GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.82,
        children: widget.catalog.categories
            .map((c) => _CategoryItem(
                  category: c,
                  onTap: () => _openCategory(c),
                ))
            .toList(),
      ),
      const SizedBox(height: 24),

      // Game Populer
      SectionHeader(
        title: 'Game Populer',
        actionLabel: 'Lihat semua',
        onAction: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GameListScreen(catalog: widget.catalog),
          ),
        ),
      ),
      SizedBox(
        height: 168,
        child: ListView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          children: widget.catalog.popularGames
              .map((g) => PopularBanner(game: g, onTap: () => _openDetail(g)))
              .toList(),
        ),
      ),
      const SizedBox(height: 24),

      // Game Terbaru
      const SectionHeader(title: 'Game Terbaru'),
      ...widget.catalog.latestGames
          .map((g) => GameListCard(game: g, onTap: () => _openDetail(g))),
    ];
  }
}

/// Avatar bulat di pojok kanan atas header.
class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accent, width: 2),
        color: AppColors.darkSlateDeep,
      ),
      clipBehavior: Clip.antiAlias,
      child: const AppImage(
        url: 'https://picsum.photos/seed/gameravatar/120/120',
        fallbackIcon: Icons.person_rounded,
      ),
    );
  }
}

/// Tombol kategori bulat berwarna oranye.
class _CategoryItem extends StatelessWidget {
  final GameCategory category;
  final VoidCallback onTap;

  const _CategoryItem({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              categoryIcon(category.icon),
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
