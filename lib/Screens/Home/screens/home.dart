import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/Home/controller/homecontroller.dart';
import 'package:notely/Screens/settings/screens/setting.dart';
import 'package:notely/Screens/auth/auth.dart';
import 'package:notely/elements/bottom_nav_bar.dart';
import 'package:notely/elements/note_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/Home/controller/homecontroller.dart';
import 'package:notely/elements/bottom_nav_bar.dart';
import 'package:notely/elements/note_box.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  final String userId;

  HomePage({super.key, required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  bool isSingleColumn = true;

  final List<Map<String, String?>> notes = [
    {"title": "UI Design", "subtitle": "UI design notes saved for later", "tags": "Designing, UI, UX", "imageUrl": "assets/notelyprofile.png"},
    {"title": "Sport Education", "subtitle": "All notes related to my sport classes", "tags": "Sport, Ski, Snowboard", "imageUrl": "assets/notelyprofile.png"},
    {"title": "Art Class Docs", "subtitle": "All notes related to my art class", "tags": "Art, Class", "imageUrl": "assets/notelyprofile.png"},
    {"title": "Renovation Inspiration", "subtitle": "All notes related to my renovation", "tags": "Inspiration, Home", "imageUrl": "assets/notelyprofile.png"},
    {"title": "Cooking Dishes", "subtitle": "Saved notes from cooking dishes", "tags": "Cooking, Recipes", "imageUrl": "assets/notelyprofile.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notely', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isSingleColumn ? Icons.grid_view : Icons.view_agenda, color: Colors.black),
            onPressed: () {
              setState(() {
                isSingleColumn = !isSingleColumn;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSingleColumn ? 1 : 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: isSingleColumn ? 2 / 1 : 1 / 1.5, // Adjusted aspect ratio for two-column layout
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteBox(
              title: note['title'] ?? 'No Title',
              subtitle: note['subtitle'] ?? 'No Subtitle',
              tags: (note['tags'] ?? '').split(', '),
              imageUrl: note['imageUrl'] ?? '',
              isSingleColumn: isSingleColumn,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
