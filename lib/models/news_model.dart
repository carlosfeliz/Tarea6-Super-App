class News {
  final String title;
  final String excerpt;
  final String link;

  News({required this.title, required this.excerpt, required this.link});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      link: json['link'],
    );
  }
}
