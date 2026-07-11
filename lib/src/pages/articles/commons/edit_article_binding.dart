import 'package:get/get.dart';

import '../controllers/article_base_controller.dart';
import '../controllers/edit_article_controller.dart';

class EditArticleBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<ArticleBaseController>(EditArticleController.new);
}
