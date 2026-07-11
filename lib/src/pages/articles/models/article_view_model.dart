class ArticleViewModel {
  final int id;
  final String title;
  final String text;
  final String? imageUrl;
  final bool isActive;
  final DateTime createdDateTime;

  ArticleViewModel({
    required this.id,
    required this.title,
    required this.text,
    this.imageUrl,
    required this.isActive,
    required this.createdDateTime,
  });

  factory ArticleViewModel.fromJson(Map<String, dynamic> json) =>
      ArticleViewModel(
        id: json["id"],
        title: json["title"],
        text: json["text"],
        imageUrl: json["image"],
        isActive: json["is_active"],
        createdDateTime: DateTime.parse(json["created_at"]),
      );
}
