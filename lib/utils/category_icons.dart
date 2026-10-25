import 'package:flutter/material.dart';

/// Pemetaan id kategori dari JSON ke ikon Material.
IconData categoryIcon(String key) {
  switch (key) {
    case 'menembak':
      return Icons.gps_fixed_rounded;
    case 'balap':
      return Icons.sports_motorsports_rounded;
    case 'strategi':
      return Icons.extension_rounded;
    case 'sport':
      return Icons.sports_soccer_rounded;
    default:
      return Icons.sports_esports_rounded;
  }
}
