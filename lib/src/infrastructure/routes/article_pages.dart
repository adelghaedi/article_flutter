import 'package:get/get.dart';

import '../../pages/articles/commons/edit_article_binding.dart';
import '../routes/article_routes.dart';

import '../../pages/articles/commons/articles_binding.dart';
import '../../pages/articles/views/articles_view.dart';
import '../../pages/articles/views/add_article_view.dart';
import '../../pages/articles/commons/add_article_binding.dart';

List<GetPage> pages = [
  GetPage(
    name: ArticleRoutes.articlesPage,
    page: ArticlesView.new,
    binding: ArticleBinding(),
  ),
  GetPage(
    name: ArticleRoutes.addArticlePage,
    page: AddArticleView.new,
    binding: AddArticleBinding(),
  ),GetPage(
    name: ArticleRoutes.editArticlePage,
    page: AddArticleView.new,
    binding: EditArticleBinding(),
  ),
];
