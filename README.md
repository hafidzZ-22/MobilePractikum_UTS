# GamerZone — Aplikasi Katalog Informasi Game

Aplikasi mobile Flutter untuk menampilkan katalog/informasi game. Dibuat untuk
**Ujian Tengah Semester (UTS) Mobile Programming**.

## Tema & Tujuan

**GamerZone** membantu pengguna menemukan informasi game seperti genre, tanggal
rilis, rating, dan Minimum System Requirements. Data yang ditampilkan saat ini
berupa **data dummy** yang tersimpan pada file JSON lokal
(`assets/data/games.json`), dan struktur datanya sudah dirancang agar mudah
diintegrasikan dengan **REST API** pada tahap pengembangan berikutnya.

## Palet Warna

| Peran        | Warna              | Hex       |
| ------------ | ------------------ | --------- |
| Header/AppBar| Dark Slate         | `#1E3838` |
| Background   | Cream / Light Yellow | `#FFFDE7` |
| Aksen/Tombol | Kuning / Oranye    | `#FFA726` |

## Daftar Halaman & Fungsinya

1. **Beranda (`home_screen.dart`)** — Header gelap berisi salam, avatar, dan
   search bar; 4 kategori (Menembak, Balap, Strategi, Sport); banner
   horizontal **Game Populer**; dan daftar **Game Terbaru**. Search bar
   menyaring game secara langsung.
2. **Daftar Game (`game_list_screen.dart`)** — Menampilkan seluruh game dalam
   `ListView` vertikal, dilengkapi filter kategori (ChoiceChip). Tombol
   "Baca Info" menuju halaman detail.
3. **Detail Game (`game_detail_screen.dart`)** — Banner besar dengan tombol
   back melayang, judul, tabel **Minimum System Requirements**, galeri
   screenshot horizontal, dan deskripsi dengan tombol **lanjut**.
4. **Tentang (`about_screen.dart`)** — Informasi aplikasi dan sumber data.

Navigasi utama memakai **BottomNavigationBar** (3 tab) dan perpindahan ke
halaman detail memakai **Navigator.push**.

## Struktur Proyek

```
lib/
├── main.dart                 # Entry point + pemuatan katalog
├── models/
│   └── game.dart             # Model Game & GameCategory (+ fromJson)
├── services/
│   └── game_repository.dart  # Pembacaan data JSON lokal (siap ganti API)
├── theme/
│   └── app_theme.dart        # Palet warna & tema global
├── utils/
│   └── category_icons.dart   # Pemetaan kategori -> ikon
├── widgets/
│   ├── app_image.dart        # Gambar + fallback bila gagal dimuat
│   ├── game_list_card.dart   # Kartu game pada list
│   ├── popular_banner.dart   # Banner "Game Populer"
│   └── section_header.dart   # Judul section
└── screens/
    ├── main_shell.dart       # BottomNavigationBar
    ├── home_screen.dart
    ├── game_list_screen.dart
    ├── game_detail_screen.dart
    └── about_screen.dart
```

## Cara Menjalankan

```bash
# 1. Pastikan Flutter terpasang
flutter --version

# 2. Ambil dependency
flutter pub get

# 3. Lihat perangkat/emulator yang tersedia
flutter emulators
flutter emulators --launch Pixel_8

# 4. Jalankan aplikasi
flutter run
```

### Catatan Data

- Seluruh konten game berada di `assets/data/games.json`.
- Gambar memakai `Image.network` dengan **fallback** bergradasi, sehingga
  aplikasi tetap tampil rapi walau tanpa koneksi internet.
- Untuk integrasi API: ganti isi `GameRepository.fetchCatalog()` dengan
  pemanggilan HTTP dan `jsonDecode` — model `Game.fromJson` sudah siap
  digunakan.
