import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class FaceAuthService {
  final ImagePicker _picker = ImagePicker();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true,
      enableContours: true,
      enableClassification: true,
    ),
  );

  // Capture image from camera
  Future<File?> captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Detect faces from image
  Future<List<Face>> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final faces = await _faceDetector.processImage(inputImage);
    return faces;
  }

  // Verify face from image
  Future<bool> verifyFace(File imageFile) async {
    try {
      final faces = await detectFaces(imageFile);
      if (faces.isEmpty) {
        return false;
      }

      // Check face quality
      final face = faces.first;
      
      // Check if face has high enough confidence
      if (face.trackingId == null || face.trackingId! < 0.8) {
        return false;
      }

      // Check if eyes are open
      if (face.leftEyeOpenProbability != null && face.leftEyeOpenProbability! < 0.5) {
        return false;
      }
      if (face.rightEyeOpenProbability != null && face.rightEyeOpenProbability! < 0.5) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // Dispose resources
  void dispose() {
    _faceDetector.close();
  }
}
