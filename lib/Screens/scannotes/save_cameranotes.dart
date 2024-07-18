import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'review_controller.dart';

class ReviewScreen extends StatelessWidget {
  final ReviewController controller = Get.put(ReviewController());
  final List<String> initialImagePaths;

  ReviewScreen({required this.initialImagePaths});

  @override
  Widget build(BuildContext context) {
    controller.setImagePaths(initialImagePaths);

    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Header(),
            SizedBox(height: 4.h),
            ImageList(),
            SizedBox(height: 2.h),
            NoteNameField(),
            SizedBox(height: 2.h),
            TagsField(),
            SizedBox(height: 2.h),
            TagsChips(),
            SizedBox(height: 2.h),
            CategorySelector(),
            SizedBox(height: 2.h),
            SaveButton(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Row(
        children: [
          Container(
            width: 26.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Color.fromRGBO(226, 221, 203, 1),
              borderRadius: BorderRadius.circular(16.5),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Color(0xFF0D1B2A)),
                ),
                Text('Previous', style: TextStyle(color: Color(0xFF0D1B2A))),
              ],
            ),
          ),
          Spacer(),
          Text(
            "Review Image",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class ImageList extends StatelessWidget {
  final ReviewController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.imagePaths.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(controller.imagePaths[index]),
                        width: 60.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2.h,
                    right: 2.w,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          controller.removeImage(controller.imagePaths[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

class NoteNameField extends StatelessWidget {
  final ReviewController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name your note",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: controller.noteNameController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF5F5DC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.5),
            ),
          ),
        ),
      ],
    );
  }
}

class TagsField extends StatelessWidget {
  final ReviewController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tags",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: controller.tagController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF5F5DC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.add, color: Color(0xFF0D1B2A)),
              onPressed: () => controller.addTag(controller.tagController.text),
            ),
          ),
          onSubmitted: (value) => controller.addTag(value),
        ),
      ],
    );
  }
}

class TagsChips extends StatelessWidget {
  final ReviewController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: controller.tags.map((tag) {
          return Chip(
            label: Text(tag, style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF415A77),
            deleteIconColor: Colors.white,
            onDeleted: () => controller.removeTag(tag),
          );
        }).toList(),
      );
    });
  }
}

class CategorySelector extends StatelessWidget {
  final ReviewController controller = Get.find();

  void showCategorySheet(BuildContext context) {
    TextEditingController newCategoryController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Color(0xFF0D1B2A),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Category",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              SizedBox(height: 2.h),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        controller.categories[index],
                        style: TextStyle(
                          color: controller.selectedCategory.value ==
                              controller.categories[index]
                              ? Color(0xFFE0A458)
                              : Colors.white,
                        ),
                      ),
                      onTap: () {
                        controller.selectCategory(controller.categories[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }),
              TextField(
                controller: newCategoryController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Add category",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Color(0xFF1B263B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.5),
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.addCategory(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCategorySheet(context),
      child: Obx(() {
        return Container(
          width: 90.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: controller.selectedCategory.value.isEmpty
                ? Color(0xFF778DA9)
                : Color(0xFF88BDFC),
            borderRadius: BorderRadius.circular(16.5),
          ),
          child: Center(
            child: Text(
              controller.selectedCategory.value.isEmpty
                  ? "Choose category"
                  : controller.selectedCategory.value,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        );
      }),
    );
  }
}

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement save logic here, including pushing data to Firebase
      },
      child: Container(
        width: 90.w,
        height: 6.h,
        decoration: BoxDecoration(
          color: Color(0xFFE0A458),
          borderRadius: BorderRadius.circular(16.5),
        ),
        child: Center(
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }
}
