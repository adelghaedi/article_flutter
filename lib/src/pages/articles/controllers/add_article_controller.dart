import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'article_base_controller.dart';
import '../models/article_insert_dto.dart';
import '../models/article_view_model.dart';

class AddArticleController extends ArticleBaseController {
  @override
  bool isAddArticlePage = true;

  @override
  void onClose() {
    titleController.dispose();
    textController.dispose();
    super.onClose();
  }

  @override
  Future<void> onPressedSubmitButton() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final ArticleInsertDto dto = ArticleInsertDto(
      title: titleController.text,
      text: textController.text,
      isActive: isActive.value,
      image: selectedImage.value,
    );

    final Either<String, ArticleViewModel> result = await repository
        .insertArticle(dto);

    result.fold(_insertArticleException, _insertArticleSuccessful);
  }

  Future<void> _insertArticleSuccessful(final ArticleViewModel article) async {
    isLoading.value = false;

    Get.back(result: article);

    Get.snackbar(
      "موفق",
      "مقاله با موفقیت اضافه شد",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<void> _insertArticleException(final String exception) async {
    isLoading.value = false;

    Get.snackbar(
      "خطا",
      "مشکلی پیش اومد: $exception",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
