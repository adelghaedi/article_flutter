import 'package:get/get.dart';

import '../controllers/article_base_controller.dart';
import '../controllers/add_article_controller.dart';

class AddArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleBaseController>(() => AddArticleController());
  }
}
