/// Model data untuk aplikasi katalog game.
///
/// Struktur dibuat menyerupai respons JSON dari REST API
/// (memiliki factory `fromJson`) sehingga mudah diintegrasikan
/// dengan backend pada tahap pengembangan berikutnya.
class Game {
  final String id;
  final String title;
  final String genre;
  final String category;
  final String developer;
  final String publisher;
  final String releaseDate;
  final double rating;
  final String size;
  final String price;
  final String thumbnail;
  final String banner;
  final bool isPopular;
  final bool isLatest;
  final String shortDescription;
  final String description;
  final Map<String, String> requirements;
  final List<String> screenshots;

  const Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.category,
    required this.developer,
    required this.publisher,
    required this.releaseDate,
    required this.rating,
    required this.size,
    required this.price,
    required this.thumbnail,
    required this.banner,
    required this.isPopular,
    required this.isLatest,
    required this.shortDescription,
    required this.description,
    required this.requirements,
    required this.screenshots,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Tanpa Judul',
      genre: json['genre'] as String? ?? '-',
      category: json['category'] as String? ?? '',
      developer: json['developer'] as String? ?? '-',
      publisher: json['publisher'] as String? ?? '-',
      releaseDate: json['releaseDate'] as String? ?? '-',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      size: json['size'] as String? ?? '-',
      price: json['price'] as String? ?? 'Gratis',
      thumbnail: json['thumbnail'] as String? ?? '',
      banner: json['banner'] as String? ?? '',
      isPopular: json['isPopular'] as bool? ?? false,
      isLatest: json['isLatest'] as bool? ?? false,
      shortDescription: json['shortDescription'] as String? ?? '',
      description: json['description'] as String? ?? '',
      requirements: (json['requirements'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value.toString())),
      screenshots: (json['screenshots'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  /// Siap dikirim / disimpan kembali ke API bila diperlukan.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'genre': genre,
        'category': category,
        'developer': developer,
        'publisher': publisher,
        'releaseDate': releaseDate,
        'rating': rating,
        'size': size,
        'price': price,
        'thumbnail': thumbnail,
        'banner': banner,
        'isPopular': isPopular,
        'isLatest': isLatest,
        'shortDescription': shortDescription,
        'description': description,
        'requirements': requirements,
        'screenshots': screenshots,
      };
}

/// Model untuk kategori game pada halaman beranda.
class GameCategory {
  final String id;
  final String name;
  final String icon;

  const GameCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory GameCategory.fromJson(Map<String, dynamic> json) {
    return GameCategory(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }
}
