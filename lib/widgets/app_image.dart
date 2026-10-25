import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Widget gambar yang tahan terhadap kegagalan jaringan.
///
/// Menampilkan shimmer/loader saat memuat dan sebuah placeholder
/// bergradasi berisi ikon game bila gambar gagal dimuat.
/// Hal ini menjaga tampilan tetap rapi walau tanpa koneksi internet.
class AppImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final IconData fallbackIcon;

  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.sports_esports_rounded,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _placeholder();

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => _placeholder(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _loader();
      },
    );
  }

  Widget _loader() {
    return Container(
      width: width,
      height: height,
      color: AppColors.creamSoft,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          color: AppColors.accent,
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkSlate, AppColors.darkSlateDeep],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        fallbackIcon,
        color: AppColors.accent,
        size: (height != null && height! < 120) ? 28 : 48,
      ),
    );
  }
}
