import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:soulsync/services/firebase_service.dart';

class StorageService {
  final FirebaseService _firebase = FirebaseService();

  // Upload profile picture
  Future<String> uploadProfilePicture(File file, String userId) async {
    try {
      // Compress image
      final compressedFile = await _compressImage(file);

      final Reference storageRef =
          _firebase.storage.ref().child('users/$userId/profile.jpg');
      final UploadTask uploadTask = storageRef.putFile(compressedFile);

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  // Upload user photos
  Future<String> uploadUserPhoto(File file, String userId, String photoId) async {
    try {
      // Compress image
      final compressedFile = await _compressImage(file);

      final Reference storageRef =
          _firebase.storage.ref().child('users/$userId/photos/$photoId.jpg');
      final UploadTask uploadTask = storageRef.putFile(compressedFile);

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  // Compress image to reduce file size
  Future<File> _compressImage(File file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.absolute.path}_compressed.jpg',
      quality: 85,
    );

    return File(result!.path);
  }

  // Delete user photo
  Future<void> deleteUserPhoto(String userId, String photoId) async {
    try {
      final Reference storageRef =
          _firebase.storage.ref().child('users/$userId/photos/$photoId.jpg');
      await storageRef.delete();
    } catch (e) {
      rethrow;
    }
  }

  // Delete profile picture
  Future<void> deleteProfilePicture(String userId) async {
    try {
      final Reference storageRef =
          _firebase.storage.ref().child('users/$userId/profile.jpg');
      await storageRef.delete();
    } catch (e) {
      rethrow;
    }
  }

  // Get download URL for a file
  Future<String> getDownloadUrl(String path) async {
    try {
      final Reference storageRef = _firebase.storage.ref().child(path);
      return await storageRef.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
