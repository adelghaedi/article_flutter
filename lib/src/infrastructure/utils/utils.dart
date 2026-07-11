import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

const int timeOut = 2000;

const Duration timeOutDuration = Duration(seconds: timeOut);

final Options requestOption = Options(contentType: Headers.jsonContentType);

const String baseUrlApi = 'http://127.0.0.1:8000/';

const String endPointUrlAPIArticles = 'articles';

const String endPointUrlApiAddArticle = 'articles/add';

const String endPointUrlUpdateArticle = 'articles/update';

const String endPointUrlDeleteArticle = 'articles/delete';

const EdgeInsets padding16 = EdgeInsets.all(16);

const SizedBox horizontalSpacer4 = SizedBox(width: 4);

const SizedBox horizontalSpacer8 = SizedBox(width: 8);

const SizedBox verticalSpacer16 = SizedBox(height: 16);

const SizedBox verticalSpacer32 = SizedBox(height: 32);

Widget customProgressBar() => const SizedBox(
  width: 20,
  height: 20,
  child: CircularProgressIndicator(
    padding: padding16,
    strokeWidth: 2,
    color: Colors.black,
  ),
);
