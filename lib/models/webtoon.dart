class Webtoon {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  double rating;

  Webtoon({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.rating = 0,
  });
}
