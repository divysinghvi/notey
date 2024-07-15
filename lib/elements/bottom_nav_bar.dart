import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Image cache
  final Map<String, Image> _imageCache = {
    'assets/filescreen.png': Image.asset('assets/filescreen.png'),
    'assets/aiscreen.png': Image.asset('assets/aiscreen.png'),
    'assets/camerascreen.png': Image.asset('assets/camerascreen.png'),
    'assets/searchscreen.png': Image.asset('assets/searchscreen.png'),
    'assets/settingscreen.png': Image.asset('assets/settingscreen.png'),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload the images here to ensure context is available
    _imageCache.values.forEach((image) {
      precacheImage(image.image, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final lessVisiblePrimaryColor = primaryColor.withOpacity(0.5);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            selectedItemColor: lessVisiblePrimaryColor,
            unselectedItemColor: primaryColor,
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Get.toNamed('/homescreen');
                  break;
                case 1:
                  Get.toNamed('/aifeaturescreen');
                  break;
                case 2:
                  Get.toNamed('/camerascreen');
                  break;
                case 3:
                  Get.toNamed('/searchscreen');
                  break;
                case 4:
                  Get.toNamed('/settingscreen');
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/filescreen.png',
                  _selectedIndex == 0 ? lessVisiblePrimaryColor : primaryColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/aiscreen.png',
                  _selectedIndex == 1 ? lessVisiblePrimaryColor : primaryColor,
                ),
                label: 'AI Features',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(top: 5), // Adjust if needed
                  child: _buildIcon(
                    'assets/camerascreen.png',
                    _selectedIndex == 2 ? lessVisiblePrimaryColor : primaryColor,
                    size: 40, // Make the camera icon larger
                  ),
                ),
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/searchscreen.png',
                  _selectedIndex == 3 ? lessVisiblePrimaryColor : primaryColor,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/settingscreen.png',
                  _selectedIndex == 4 ? lessVisiblePrimaryColor : primaryColor,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String assetPath, Color color, {double size = 24}) {
    return ImageIcon(
      _imageCache[assetPath]!.image,
      color: color,
      size: size,
    );
  }
}
