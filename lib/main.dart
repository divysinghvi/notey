import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notely/Screens/Home/screens/home.dart';
import 'package:notely/Screens/auth/startscreen.dart';
import 'package:notely/Screens/scannotes/camera_screen.dart';
import 'package:notely/Screens/searchscreens/search_screen.dart';
import 'package:notely/Screens/settings/elements/themecontrollr.dart';
import 'package:notely/Screens/settings/screens/setting.dart';
import 'package:notely/Screens/auth/auth.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      final ThemeController themeController = Get.put(ThemeController());

      return Obx(
            () {
          return GetMaterialApp(
            theme: themeController.lightTheme,
            darkTheme: themeController.darkTheme,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            initialRoute: '/start',
            getPages: [
              GetPage(name: '/start', page: () => StartScreen()),
              GetPage(
                name: '/homescreen',
                page: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    return HomePage(userId: user.uid);
                  } else {
                    return StartScreen(); // Redirect to start screen if no user is logged in
                  }
                },
              ),
              GetPage(name: '/aifeaturescreen', page: () => SearchScreen()),
              GetPage(name: '/camerascreen', page: () => CameraScreen()),
              GetPage(name: '/searchscreen', page: () => SearchScreen()),
              GetPage(name: '/settingscreen', page: () {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
              return SettingsPage(name: user.displayName ?? 'User');
              } else {
              return StartScreen(); // Redirect to start screen if no user is logged in
              }
              })
            ]
          );
        },
      );
    });
  }
}
