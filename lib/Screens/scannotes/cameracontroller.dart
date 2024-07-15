import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MyCameraController {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isFlashOn = false;
  bool isScanNotesActive = false;
  List<String> imagePaths = [];

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras![0], ResolutionPreset.high);
    await cameraController!.initialize();
  }

  void dispose() {
    cameraController?.dispose();
  }

  Future<void> toggleFlash() async {
    isFlashOn = !isFlashOn;
    await cameraController?.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
  }

  Future<void> takePicture() async {
    if (!cameraController!.value.isInitialized) {
      return;
    }
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = join(directory.path, '${DateTime.now()}.png');
      final XFile picture = await cameraController!.takePicture();
      await picture.saveTo(imagePath);
      imagePaths.add(imagePath);
    } catch (e) {
      print(e);
    }
  }
}
