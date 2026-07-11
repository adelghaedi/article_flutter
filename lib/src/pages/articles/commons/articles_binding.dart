import 'package:get/get.dart';

import '../controllers/articles_controller.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ArticlesController());
}
