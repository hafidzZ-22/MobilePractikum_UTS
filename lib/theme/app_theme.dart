import 'package:flutter/material.dart';

/// Palet warna dan tema global aplikasi "GamerZone".
///
/// Konsistensi warna dijaga melalui konstanta di kelas [AppColors]
/// sehingga mudah diubah dari satu tempat.
class AppColors {
  static const Color darkSlate = Color(0xFF1E3838);
  static const Color darkSlateDeep = Color(0xFF193330);
  static const Color cream = Color(0xFFFFFDE7);
  static const Color creamSoft = Color(0xFFFFF8E7);
  static const Color accent = Color(0xFFFFA726);
  static const Color accentDeep = Color(0xFFFFB300);
  static const Color textDark = Color(0xFF1C2B2B);
  static const Color textMuted = Color(0xFF6B7B7B);
  static const Color card = Colors.white;
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        primary: AppColors.darkSlate,
        secondary: AppColors.accent,
        surface: AppColors.cream,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSlate,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
