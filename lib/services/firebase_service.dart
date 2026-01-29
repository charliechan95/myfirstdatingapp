import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  bool _isInitialized = false;
  bool _isConfigured = false;

  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  FirebaseMessaging get messaging => FirebaseMessaging.instance;

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _isInitialized = true;
      _isConfigured = true;
      print('Firebase initialized successfully');
    } catch (e) {
      print('Firebase initialization failed: $e');
      _isInitialized = true;
      _isConfigured = false;
    }
  }

  bool get isConfigured => _isConfigured;

  // Get current user
  User? get currentUser => auth.currentUser;

  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;
}
