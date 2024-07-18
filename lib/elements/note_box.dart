import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:notely/Screens/settings/elements/themecontrollr.dart';

class NoteBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> tags;
  final String imageUrl;
  final bool isSingleColumn;

  // Add a field for themeController
  final ThemeController themeController;

  const NoteBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.imageUrl,
    required this.isSingleColumn,
    required this.themeController, // Include themeController in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: themeController.NoteColorHome, // Accessing themeController properties
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: EdgeInsets.symmetric(vertical: .5.h),
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: isSingleColumn
            ? _buildSingleColumnLayout(context)
            : _buildMultiColumnLayout(context),
      ),
    );
  }

  Widget _buildMultiColumnLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 0.5.h),
        Text(
          subtitle,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 1.w,
          runSpacing: 0.5.h,
          children: tags
              .map((tag) => Chip(
            label: Text(
              tag.trim(),
              style: TextStyle(fontSize: 9.sp),
            ),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            labelStyle: TextStyle(color: Colors.white),
          ))
              .toList(),
        ),
        SizedBox(height: 2.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            imageUrl,
            height: 10.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildSingleColumnLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 0.5.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            imageUrl,
            height: 10.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          subtitle,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Wrap(
          spacing: 1.w,
          runSpacing: 0.5.h,
          children: tags
              .map((tag) => Chip(
            label: Text(
              tag.trim(),
              style: TextStyle(fontSize: 7.sp),
            ),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            labelStyle: TextStyle(color: Colors.white),
          ))
              .toList(),
        ),
      ],
    );
  }
}
