import 'package:flutter/material.dart';

import '../services/game_repository.dart';
import '../theme/app_theme.dart';
import 'about_screen.dart';
import 'game_list_screen.dart';
import 'home_screen.dart';

/// Kerangka utama aplikasi yang menampung BottomNavigationBar.
///
/// Tab Beranda dan Daftar Game menggunakan data [catalog] yang sama,
/// sedangkan halaman Detail diakses melalui Navigator.push.
class MainShell extends StatefulWidget {
  final GameCatalog catalog;

  const MainShell({super.key, required this.catalog});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(catalog: widget.catalog),
      GameListScreen(catalog: widget.catalog),
      const AboutScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.accent.withValues(alpha: 0.25),
        height: 66,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.darkSlate),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon:
                Icon(Icons.sports_esports_rounded, color: AppColors.darkSlate),
            label: 'Daftar Game',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            selectedIcon:
                Icon(Icons.info_rounded, color: AppColors.darkSlate),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}
