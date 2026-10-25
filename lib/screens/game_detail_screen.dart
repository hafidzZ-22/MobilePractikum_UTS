import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';
import '../widgets/app_image.dart';

/// Halaman Detail Game (Detail Screen).
///
/// Banner besar di bagian atas dengan tombol back melayang, dilanjutkan
/// kartu putih berisi judul, tabel Minimum System Requirements, galeri
/// screenshot, dan deskripsi. Susunan dibuat memakai [CustomScrollView]
/// dan [SliverAppBar] agar banner dapat mengecil secara halus saat digulir.
class GameDetailScreen extends StatefulWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildBanner(context, game),
            _buildContentCard(game),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context, Game game) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImage(
            url: game.banner,
            fit: BoxFit.cover,
            fallbackIcon: Icons.videogame_asset_rounded,
          ),
          // Gradasi gelap di tepi agar tombol melayang tetap terbaca.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.35),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          Positioned(
            top: topPadding + 8,
            left: 14,
            child: _RoundIconButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: topPadding + 8,
            right: 14,
            child: _RoundIconButton(
              icon: Icons.bookmark_border_rounded,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ditambahkan ke favorit')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(Game game) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            game.title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star_rounded,
                  color: AppColors.accentDeep, size: 18),
              const SizedBox(width: 3),
              Text(
                '${game.rating}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 10),
              _Pill(text: game.genre),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoGrid(game),
          const SizedBox(height: 26),
          _sectionTitle('Minimum System Requirements'),
          const SizedBox(height: 12),
          _buildRequirementsTable(game),
          const SizedBox(height: 26),
          _sectionTitle('Galeri Screenshot'),
          const SizedBox(height: 12),
          _buildGallery(game),
          const SizedBox(height: 26),
          _sectionTitle('Deskripsi'),
          const SizedBox(height: 10),
          Text(
            _expanded ? game.description : game.shortDescription,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.6,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () => setState(() => _expanded = !_expanded),
            icon: Icon(
              _expanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 18,
            ),
            label: Text(_expanded ? 'sembunyikan' : 'lanjut'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoGrid(Game game) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Pill(icon: Icons.business_center_outlined, text: game.developer),
        _Pill(icon: Icons.calendar_today_outlined, text: game.releaseDate),
        _Pill(icon: Icons.sd_storage_outlined, text: game.size),
        _Pill(icon: Icons.sell_outlined, text: game.price),
      ],
    );
  }

  Widget _buildRequirementsTable(Game game) {
    final entries = game.requirements.entries.toList();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.black, width: 0.06),
        ),
        children: [
          for (var i = 0; i < entries.length; i++)
            TableRow(
              decoration: BoxDecoration(
                color: i.isEven
                    ? Colors.transparent
                    : Colors.white.withValues(alpha: 0.6),
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Text(
                    entries[i].key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Text(
                    entries[i].value,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildGallery(Game game) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: game.screenshots.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AppImage(
              url: game.screenshots[index],
              width: 170,
              height: 110,
              fallbackIcon: Icons.image_outlined,
            ),
          );
        },
      ),
    );
  }
}

/// Tombol ikon bulat semi transparan yang dipakai pada [SliverAppBar].
class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black.withValues(alpha: 0.4),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}

/// Label kecil berbentuk pil.
class _Pill extends StatelessWidget {
  final String text;
  final IconData? icon;

  const _Pill({required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: AppColors.textMuted),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
