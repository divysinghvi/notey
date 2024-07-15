import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReviewScreen extends StatefulWidget {
  final List<String> imagePaths;

  ReviewScreen({required this.imagePaths});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<String> imagePaths = [];
  TextEditingController noteNameController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController notebookController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    imagePaths = widget.imagePaths;
  }

  void removeImage(String path) {
    setState(() {
      imagePaths.remove(path);
    });
    File(path).delete(); // Optionally delete the file from storage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Images'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(imagePaths);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
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
                              File(imagePaths[index]),
                              width: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2.h,
                          right: 2.w,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              removeImage(imagePaths[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: noteNameController,
              decoration: InputDecoration(
                labelText: 'Note Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: tagsController,
              decoration: InputDecoration(
                labelText: 'Tags (comma separated)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: notebookController,
              decoration: InputDecoration(
                labelText: 'Notebook/Collection',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'imagePaths': imagePaths,
                    'noteName': noteNameController.text,
                    'tags': tagsController.text,
                    'notebook': notebookController.text,
                    'description': descriptionController.text,
                  });
                },
                child: Text('Save Note'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // Match your app's color scheme
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  textStyle: TextStyle(fontSize: 12.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
