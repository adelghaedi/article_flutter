import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../controllers/article_base_controller.dart';

class AddArticleView<T extends ArticleBaseController> extends GetView<T> {
  const AddArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() => AppBar(
    title: const Text("افزودن مقاله"),
    centerTitle: true,
    actions: [
      Obx(
        () => controller.isLoading.value
            ? utils.customProgressBar()
            : IconButton(
                padding: utils.padding16,
                onPressed: controller.onPressedSubmitButton,
                icon: const Icon(Icons.check),
                tooltip: "ثبت مقاله",
              ),
      ),
    ],
  );

  Widget _buildBody() => Form(
    key: controller.formKey,
    child: SingleChildScrollView(
      padding: utils.padding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImagePicker(),
          utils.verticalSpacer32,
          _buildTitleField(),
          utils.verticalSpacer16,
          _buildTextField(),
          utils.verticalSpacer16,
          _buildIsActiveToggle(),
          utils.verticalSpacer32,
          _buildSubmitButton(),
        ],
      ),
    ),
  );

  InputDecoration _buildTextFieldDecoration() => InputDecoration(
    labelText: "متن مقاله",
    hintText: "متن مقاله را وارد کنید...",
    prefixIcon: Icon(Icons.article_outlined),
    border: OutlineInputBorder(),
    alignLabelWithHint: true,
  );

  InputDecoration _buildTitleFieldDecoration() => const InputDecoration(
    labelText: "عنوان مقاله",
    hintText: "عنوان را وارد کنید...",
    prefixIcon: Icon(Icons.title),
    border: OutlineInputBorder(),
  );

  Widget _buildImagePicker() => Obx(() {
    final hasNewImage = controller.selectedImage.value != null;
    final hasExistingImage = controller.existingImageUrl.value != null;

    Widget imageWidget;

    if (hasNewImage) {
      imageWidget = kIsWeb
          ? Image.network(
              controller.selectedImage.value!.path,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(controller.selectedImage.value!.path),
              fit: BoxFit.cover,
            );
    } else if (hasExistingImage) {
      imageWidget = Image.network(
        utils.baseUrlApi + controller.existingImageUrl.value!,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            "انتخاب تصویر (اختیاری)",
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: controller.pickImage,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: (hasNewImage || hasExistingImage)
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageWidget,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: controller.removeImage,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : imageWidget,
      ),
    );
  });

  Widget _buildTitleField() {
    return TextFormField(
      controller: controller.titleController,
      validator: controller.validateTitle,
      textInputAction: TextInputAction.next,
      decoration: _buildTitleFieldDecoration(),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: controller.textController,
      validator: controller.validateText,
      maxLines: 6,
      textInputAction: TextInputAction.newline,
      decoration: _buildTextFieldDecoration(),
    );
  }

  Widget _buildIsActiveToggle() {
    return Obx(
      () => Card(
        child: SwitchListTile(
          title: const Text("وضعیت انتشار"),
          subtitle: Text(
            controller.isActive.value ? "منتشر شده" : "پیش‌نویس",
            style: TextStyle(
              color: controller.isActive.value ? Colors.green : Colors.orange,
            ),
          ),
          secondary: Icon(
            controller.isActive.value ? Icons.visibility : Icons.visibility_off,
            color: controller.isActive.value ? Colors.green : Colors.orange,
          ),
          value: controller.isActive.value,
          onChanged: controller.toggleIsActive,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(
      () => ElevatedButton.icon(
        onPressed: controller.isLoading.value
            ? null
            : controller.onPressedSubmitButton,
        icon: controller.isLoading.value
            ? utils.customProgressBar()
            : const Icon(Icons.send),
        label: Text(
          controller.isLoading.value ? "در حال ارسال..." : "ثبت مقاله",
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
