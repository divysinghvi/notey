import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:notely/Screens/scannotes/save_cameranotes.dart';
import 'package:notely/Screens/scannotes//cameracontroller.dart';
import 'package:notely/elements/style.dart';
import 'package:sizer/sizer.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final MyCameraController cameraController = MyCameraController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    await cameraController.initializeCamera();
    setState(() {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void toggleFlash() async {
    await cameraController.toggleFlash();
    setState(() {});
  }

  Future<void> takePicture() async {
    await cameraController.takePicture();
    setState(() {});
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 80, // Adjust 80 based on the image width and padding
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void navigateToReviewScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewScreen(initialImagePaths: cameraController.imagePaths)),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 26.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(16.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, color: secondaryHeaderColor),
            SizedBox(width: 2.w),
            Text('Previous', style: TextStyle(color: secondaryHeaderColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashButton() {
    return GestureDetector(
      onTap: toggleFlash,
      child: Container(
        width: 23.w,
        height: 5.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          cameraController.isFlashOn ? 'assets/flashon.png' : 'assets/flashoff.png',
          width: 10.w,
          height: 10.w,
        ),
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToReviewScreen(context),
      child: Container(
        width: 23.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(16.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Done', style: TextStyle(color: secondaryHeaderColor)),
            Icon(Icons.check, color: secondaryHeaderColor),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      color: Color(0xFF0A1930),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildScanNotesButton(),
        ],
      ),
    );
  }

  Widget _buildScanNotesButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          cameraController.isScanNotesActive = true;
        });
        takePicture();
      },
      child: _buildDynamicButton(
        label: 'Scan Notes',
        imagePath: 'assets/scanimage.png',
        isActive: cameraController.isScanNotesActive,
      ),
    );
  }


  Widget _buildDynamicButton({required String label, required String imagePath, required bool isActive}) {
    return Column(
      children: [
        Container(
          width: 15.w,
          height: 15.w,
          child: Center(
            child: Image.asset(imagePath, width: 15.w, height: 15.w),
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.cameraController == null || !cameraController.cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Color(0xFF0A1930),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CameraPreview(cameraController.cameraController!),
                Positioned(
                  top: 4.h,
                  left: 2.w,
                  right: 2.w,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBackButton(context),
                        _buildFlashButton(),
                        _buildDoneButton(context),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2.h, // Adjusted from 10.h to 22.h
                  left: 2.w,
                  right: 2.w,
                  child: SizedBox(
                    height: 12.h,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: cameraController.imagePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(1.w),
                          child: Image.file(
                            File(cameraController.imagePaths[index]),
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }
}
