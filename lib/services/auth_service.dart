import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulsync/data/models.dart';
import 'package:soulsync/services/firebase_service.dart';

class AuthService {
  final FirebaseService _firebase = FirebaseService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Check if Firebase is configured
  bool get isFirebaseConfigured => _firebase.isConfigured;

  // Sign up with email and password
  Future<firebase_auth.UserCredential> signUpWithEmail(
      String email, String password, Map<String, dynamic> userData) async {
    if (!isFirebaseConfigured) {
      throw Exception('Firebase is not configured');
    }

    try {
      final firebase_auth.UserCredential userCredential =
          await _firebase.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email and password
  Future<firebase_auth.UserCredential> signInWithEmail(
      String email, String password) async {
    if (!isFirebaseConfigured) {
      throw Exception('Firebase is not configured');
    }

    try {
      return await _firebase.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<firebase_auth.UserCredential> signInWithGoogle() async {
    if (!isFirebaseConfigured) {
      throw Exception('Firebase is not configured');
    }

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await _firebase.auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with phone number
  Future<firebase_auth.ConfirmationResult> signInWithPhoneNumber(
      String phoneNumber) async {
    if (!isFirebaseConfigured) {
      throw Exception('Firebase is not configured');
    }

    try {
      return await _firebase.auth.signInWithPhoneNumber(phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  // Verify phone number with SMS code
  Future<firebase_auth.UserCredential> verifyPhoneNumber(
      String verificationId, String smsCode) async {
    if (!isFirebaseConfigured) {
      throw Exception('Firebase is not configured');
    }

    try {
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential =
          await _firebase.auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebase.auth.signOut();
  }

  // Get current user stream
  Stream<firebase_auth.User?> get userStream =>
      _firebase.auth.authStateChanges();

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebase.auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Verify email
  Future<void> sendEmailVerification() async {
    final user = _firebase.auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
