import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/article_repository.dart';

abstract class ArticleBaseController extends GetxController {
  abstract bool isAddArticlePage;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final titleController = TextEditingController();
  final textController = TextEditingController();

  // State variables
  final RxBool isLoading = false.obs;
  final RxBool isActive = true.obs;
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final Rx<String?> existingImageUrl = Rx<String?>(null);

  final ArticleRepository repository = ArticleRepository();

  void toggleIsActive(bool? value) {
    isActive.value = value ?? true;
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      selectedImage.value = image;
    }
  }

  void removeImage() {
    selectedImage.value = null;
    existingImageUrl.value = null;
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "عنوان مقاله نمی تواند خالی باشد.";
    }
    if (value.trim().length < 3) {
      return "عنوان مقاله باید حداقل 3 کاراکتر باشد.";
    }
    return null;
  }

  String? validateText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "متن مقاله نمیتونه خالی باشه";
    }
    if (value.trim().length < 10) {
      return "متن مقاله باید حداقل ۱۰ کاراکتر باشه";
    }
    return null;
  }

  Future<void> onPressedSubmitButton();
}
