import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../models/article_view_model.dart';
import '../controllers/articles_controller.dart';

class ArticlesView extends GetView<ArticlesController> {
  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context) => Obx(
    () => Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    ),
  );

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return utils.customProgressBar();
    }
    if (controller.articleList.isEmpty) {
      return _buildEmptyList();
    }
    return _buildListView();
  }

  Widget _buildEmptyList() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.article_outlined, size: 64, color: Colors.grey.shade400),
        utils.verticalSpacer16,
        Text(
          "مقاله‌ای یافت نشد",
          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
        ),
      ],
    ),
  );

  Widget _buildListView() => RefreshIndicator(
    onRefresh: controller.onRefreshListView,
    child: ListView.builder(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 80),
      itemCount: controller.articleList.length,
      itemBuilder: _buildItemListView,
    ),
  );

  Widget _buildItemListView(BuildContext context, int index) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      _buildImageCard(index),
      _buildBodyCard(index),
      _buildCartFooter(controller.articleList[index].id),
    ],
  );

  Widget _buildBodyCard(int index) {
    final ArticleViewModel article = controller.articleList[index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: Column(
        children: [
          _statusAndCreatedDateRow(article.isActive, article.createdDateTime),
          _buildTitleArticle(article.title),
          utils.verticalSpacer16,
          _buildTextArticle(article.text),
        ],
      ),
    );
  }

  Widget _buildCartFooter(int articleId) => Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _editAndDeleteButtonRow(articleId),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () => controller.onTapEditButton(articleId),
          color: Colors.grey,
        ),
      ],
    ),
  );

  Widget _editAndDeleteButtonRow(int articleId) {
    return Row(
      children: [
        _buildButton(
          label: "ویرایش",
          icon: Icons.edit,
          onTap: () => controller.onTapEditButton(articleId),
        ),
        utils.horizontalSpacer8,
        _buildButton(
          label: "حذف",
          icon: Icons.delete_outline,
          onTap: () => controller.onTapDeleteButton(articleId),
          isDanger: true,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final Color color = isDanger ? Colors.red.shade700 : Colors.grey.shade600;
    final Color bgColor = isDanger ? Colors.red.shade50 : Colors.grey.shade100;
    final Color borderColor = isDanger
        ? Colors.red.shade200
        : Colors.grey.shade300;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: bgColor,
          border: BoxBorder.all(color: borderColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 13, color: color),
            utils.horizontalSpacer4,
            Text(label, style: TextStyle(fontSize: 12, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextArticle(String text) => Text(
    text,
    style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
  );

  Widget _buildTitleArticle(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      color: Colors.grey,
    ),
  );

  Widget _statusAndCreatedDateRow(bool isActive, DateTime createdDateTime) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusBadge(isActive),
          _createdDateTimeRow(createdDateTime),
        ],
      );

  Widget _createdDateTimeRow(DateTime createdDateTime) => Row(
    children: [
      const Icon(Icons.access_time, size: 12, color: Colors.grey),
      utils.horizontalSpacer4,
      Text(_formatDate(createdDateTime), style: TextStyle(fontSize: 12)),
    ],
  );

  BoxDecoration _buildStatusBadgeDecoration(bool isActive) => BoxDecoration(
    color: isActive ? Colors.green.shade50 : Colors.orange.shade50,
    border: Border.all(
      color: isActive ? Colors.green.shade200 : Colors.orange.shade200,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      decoration: _buildStatusBadgeDecoration(isActive),
      child: Text(
        isActive ? "منشتر شده" : "پیش نویس",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isActive ? Colors.green.shade700 : Colors.orange.shade700,
        ),
      ),
    );
  }

  BoxDecoration _buildImageCardDecoration() => BoxDecoration(
    color: Colors.blue.shade200,
    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  );

  Widget _buildImageCard(int index) {
    final String? imageUrl = controller.articleList[index].imageUrl;
    if (imageUrl == null) {
      return Container(
        width: double.infinity,
        height: 300,
        decoration: _buildImageCardDecoration(),
        child: Icon(
          Icons.article_outlined,
          size: 48,
          color: Colors.blue.shade50,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        child: Image.network(
          utils.baseUrlApi + imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  AppBar _buildAppBar() =>
      AppBar(title: const Text("مقاله ها"), centerTitle: true);

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildFloatingActionButton() => FloatingActionButton.extended(
    onPressed: controller.onPressedFloatingActionButton,
    label: const Text("ایجاد مقاله"),
    icon: const Icon(Icons.add),
  );
}
