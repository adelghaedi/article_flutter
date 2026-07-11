import 'package:image_picker/image_picker.dart';

class ArticleInsertDto {
  final String title;
  final String text;
  XFile? image;
  final bool isActive;

  ArticleInsertDto({
    required this.title,
    required this.text,
    this.image,
    required this.isActive,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "text": text,
    "image": image,
    "is_active": isActive,
  };
}
