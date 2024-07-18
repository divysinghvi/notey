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
import 'package:notely/elements/style.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/auth/auth.dart';
import 'package:notely/Screens/settings/screens/setting.dart';
import 'package:notely/Screens/Home/controller/homecontroller.dart';
import 'package:notely/elements/bottom_nav_bar.dart';
import 'package:notely/elements/note_box.dart';
import 'package:sizer/sizer.dart';
import 'package:notely/Screens/settings/elements/themecontrollr.dart'; // Make sure to import themeController

class HomePage extends StatefulWidget {
  final String userId;

  HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());
  bool isSingleColumn = true;

  final List<Map<String, String?>> notes = [
    {
      "title": "UI Design",
      "subtitle": "UI design notes saved for later",
      "tags": "Designing, UI, UX",
      "imageUrl": "assets/notelyprofile.png"
    },
    {
      "title": "Sport Education",
      "subtitle": "All notes related to my sport classes",
      "tags": "Sport, Ski, Snowboard",
      "imageUrl": "assets/notelyprofile.png"
    },
    {
      "title": "Art Class Docs",
      "subtitle": "All notes related to my art class",
      "tags": "Art, Class",
      "imageUrl": "assets/notelyprofile.png"
    },
    {
      "title": "Renovation Inspiration",
      "subtitle": "All notes related to my renovation",
      "tags": "Inspiration, Home",
      "imageUrl": "assets/notelyprofile.png"
    },
    {
      "title": "Cooking Dishes",
      "subtitle": "Saved notes from cooking dishes",
      "tags": "Cooking, Recipes",
      "imageUrl": "assets/notelyprofile.png"
    },
  ];

  // Define themeController instance here
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    // Initialize themeController here or from where it's instantiated
    themeController = Get.put(ThemeController()); // Example of initialization, adjust as per your setup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'All saved notes in Notely',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Notes Stacks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Drafts'),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(
                        isSingleColumn ? Icons.grid_view : Icons.view_agenda,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isSingleColumn = !isSingleColumn;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSingleColumn ? 1 : 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: isSingleColumn ? 3 / 2 : 1 / 1.7,
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
                    themeController: themeController, // Pass themeController to NoteBox
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
