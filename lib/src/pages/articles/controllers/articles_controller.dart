import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../infrastructure/routes/article_routes.dart';
import '../models/article_view_model.dart';
import '../repositories/article_repository.dart';

class ArticlesController extends GetxController {
  final ArticleRepository _repository = ArticleRepository();

  RxBool isLoading = false.obs;
  RxList<ArticleViewModel> articleList = RxList();

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getArticlesList();
  }

  void onTapEditButton(int articleId) =>
      Get.toNamed(ArticleRoutes.editArticlePage, arguments: articleId);

  void onTapDeleteButton(int articleId) async {
    isLoading.value = true;
    final result = await _repository.deleteArticle(articleId);
    result.fold(_deleteArticleException, (_) {
      articleList.removeWhere((article) => article.id == articleId);
      isLoading.value = false;
    });
  }

  void _deleteArticleException(String exception) {
    isLoading.value = false;
  }

  Future<void> onRefreshListView() async {
    isLoading.value = true;
    getArticlesList();
  }

  Future<void> getArticlesList() async {
    final Either<String, List<ArticleViewModel>> result = await _repository
        .getArticles();

    result.fold(_getArticlesListException, _getArticlesListSuccessful);
  }

  void _getArticlesListException(String exception) {
    isLoading.value = false;
  }

  void _getArticlesListSuccessful(List<ArticleViewModel> articles) {
    articleList.value = articles;
    isLoading.value = false;
  }

  void onPressedFloatingActionButton() async {
    final articleAdded = await Get.toNamed(ArticleRoutes.addArticlePage);

    if (articleAdded != null && articleAdded is ArticleViewModel) {
      articleList.insert(0, articleAdded);
    }
  }
}
