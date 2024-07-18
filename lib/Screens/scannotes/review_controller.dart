import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReviewController extends GetxController {
  var imagePaths = <String>[].obs;
  var noteNameController = TextEditingController();
  var tagController = TextEditingController();
  var categories = ["School", "Miscellaneous", "Work"].obs;
  var selectedCategory = "".obs;
  var tags = <String>[].obs;

  void setImagePaths(List<String> paths) {
    imagePaths.assignAll(paths);
  }

  void removeImage(String path) {
    imagePaths.remove(path);
    File(path).delete(); // Optionally delete the file from storage
  }

  void addCategory(String category) {
    if (category.isNotEmpty) {
      categories.add(category);
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void addTag(String tag) {
    if (tag.isNotEmpty) {
      tags.add(tag);
      tagController.clear();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }
}
