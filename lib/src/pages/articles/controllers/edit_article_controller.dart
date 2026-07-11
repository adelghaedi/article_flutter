import 'package:article_flutter/src/pages/articles/models/article_update_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'article_base_controller.dart';
import '../models/article_view_model.dart';

class EditArticleController extends ArticleBaseController {
  late final int articleId;

  @override
  bool isAddArticlePage = false;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    articleId = Get.arguments as int;
    getArticle(articleId);
  }

  Future getArticle(int articleId) async {
    final Either<String, ArticleViewModel> result = await repository
        .getArticleWithId(articleId);

    result.fold(_getArticleException, _getArticleSuccessful);
  }

  void _getArticleSuccessful(ArticleViewModel article) {
    // initial
    titleController.text = article.title;
    textController.text = article.text;
    isActive.value = article.isActive;
    existingImageUrl.value = article.imageUrl;

    isLoading.value = false;
  }

  void _getArticleException(String exception) {
    isLoading.value = false;
  }

  @override
  Future<void> onPressedSubmitButton() async {
    isLoading.value = true;

    final ArticleUpdateDto dto = ArticleUpdateDto(
      title: titleController.text,
      text: textController.text,
      isActive: isActive.value,
      image: selectedImage.value,
    );

    final Either<String, String> result = await repository.updateArticleWithId(
      articleId,
      dto,
    );
    result.fold(_editArticleException, _editArticleSuccessful);
  }

  void _editArticleException(String exception) {
    isLoading.value = false;

    Get.snackbar(
      "خطا",
      "مشکلی پیش اومد: $exception",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _editArticleSuccessful(String _) {
    isLoading.value = false;

    Get.back();

    Get.snackbar(
      "موفق",
      "مقاله با موفقیت ویرایش شد",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

  }
}
