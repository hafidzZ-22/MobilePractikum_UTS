import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Halaman Tentang aplikasi (About Screen).
///
/// Menjelaskan tujuan aplikasi serta menjadi tempat informasi
/// pengembangan lanjutan (integrasi API).
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(title: const Text('Tentang')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    color: AppColors.darkSlate,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.sports_esports_rounded,
                      color: AppColors.accent, size: 44),
                ),
                const SizedBox(height: 14),
                const Text(
                  'GamerZone',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Katalog Informasi Game',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _AboutCard(
            icon: Icons.info_outline_rounded,
            title: 'Tentang Aplikasi',
            body:
                'GamerZone adalah aplikasi katalog game yang menampilkan informasi '
                'seperti genre, tanggal rilis, rating, hingga Minimum System '
                'Requirements. Dibuat sebagai proyek UTS Mobile Programming.',
          ),
          const SizedBox(height: 12),
          const _AboutCard(
            icon: Icons.dataset_outlined,
            title: 'Sumber Data',
            body:
                'Saat ini data dimuat dari file JSON lokal (assets/data/games.json). '
                'Struktur data sudah dirancang agar mudah diintegrasikan dengan '
                'REST API pada tahap pengembangan berikutnya.',
          ),
          const SizedBox(height: 12),
          const _AboutCard(
            icon: Icons.layers_outlined,
            title: 'Halaman',
            body:
                '1. Beranda — kategori, game populer, dan game terbaru.\n'
                '2. Daftar Game — seluruh game dengan filter kategori.\n'
                '3. Detail Game — banner, system requirements, galeri, deskripsi.',
          ),
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _AboutCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.55,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
