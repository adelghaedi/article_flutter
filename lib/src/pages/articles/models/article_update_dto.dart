import 'package:image_picker/image_picker.dart';

class ArticleUpdateDto {
  final String title;
  final String text;
  XFile? image;
  final bool isActive;

  ArticleUpdateDto({
    required this.title,
    required this.text,
    required this.isActive,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "text": text,
    "image": image,
    "is_active": isActive,
  };
}
