import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/infrastructure/routes/article_pages.dart';
import 'src/infrastructure/routes/article_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    textDirection: TextDirection.rtl,
    debugShowCheckedModeBanner: false,
    getPages: pages,
    initialRoute: ArticleRoutes.articlesPage,
  );
}
