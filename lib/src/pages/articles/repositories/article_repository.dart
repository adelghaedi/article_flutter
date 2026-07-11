import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../infrastructure/utils/utils.dart' as utils;

import '../models/article_view_model.dart';
import '../models/article_insert_dto.dart';
import '../models/article_update_dto.dart';

class ArticleRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: utils.baseUrlApi,
      connectTimeout: utils.timeOutDuration,
      sendTimeout: utils.timeOutDuration,
      receiveTimeout: utils.timeOutDuration,
    ),
  );

  Future<Either<String, String>> updateArticleWithId(
    int articleId,
    ArticleUpdateDto dto,
  ) async {
    try {
      final FormData formData = FormData.fromMap({
        "title": dto.title,
        "text": dto.text,
        "is_active": dto.isActive,
        if (dto.image != null)
          "image": MultipartFile.fromBytes(
            await dto.image!.readAsBytes(),
            filename: dto.image!.name,
          ),
      });

      await _dio.put(
        "${utils.endPointUrlUpdateArticle}/$articleId",
        data: formData,
      );

      return const Right("Updated");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ArticleViewModel>> getArticleWithId(
    int articleId,
  ) async {
    try {
      final Response response = await _dio.get(
        "${utils.endPointUrlAPIArticles}/$articleId",
        options: utils.requestOption,
      );
      return Right(
        ArticleViewModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteArticle(int articleId) async {
    try {
      await _dio.delete(
        "${utils.endPointUrlDeleteArticle}/$articleId",
        options: utils.requestOption,
      );

      return const Right("Deleted");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ArticleViewModel>>> getArticles() async {
    try {
      final Response response = await _dio.get(
        utils.endPointUrlAPIArticles,
        options: utils.requestOption,
      );

      return Right(
        (response.data as List<dynamic>)
            .map((json) => ArticleViewModel.fromJson(json))
            .toList(),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ArticleViewModel>> insertArticle(
    ArticleInsertDto dto,
  ) async {
    try {
      final FormData formData = FormData.fromMap({
        "title": dto.title,
        "text": dto.text,
        "is_active": dto.isActive,
        if (dto.image != null)
          "image": MultipartFile.fromBytes(
            await dto.image!.readAsBytes(),
            filename: dto.image!.name,
          ),
      });
      final Response result = await _dio.post(
        utils.endPointUrlApiAddArticle,
        data: formData,
      );
      return Right(ArticleViewModel.fromJson(result.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
