import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> registerWithEmailAndPassword(
    String email, String password, String firstName, String lastName, 
    String userName, String phone, String birthday, String gender
  ) async {
    try {
      // Step 1: Create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        print("✅ User created successfully: ${user.uid}");

        // ✅ Step 2: Store user details in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,  // ✅ Store UID for reference
          'first_name': firstName,
          'last_name': lastName,
          'username': userName,
          'email': email,
          'phone': phone,
          'birthday': birthday,
          'gender': gender,
          'created_at': FieldValue.serverTimestamp(),
        });

        print("✅ User successfully saved to Firestore!");
        return user;
      } else {
        print("❌ Firebase Auth returned a null user.");
      }
    } on FirebaseAuthException catch (e) {
      print("🔥 Firebase Auth Error: ${e.code} - ${e.message}");
    } on FirebaseException catch (e) {
      print("🔥 Firestore Error: ${e.code} - ${e.message}");
    } catch (e) {
      print("🔥 Unknown Error: $e");
    }
    return null;
  }


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("Login failed: $e");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: "39620182153-i8550jb9tr2852fpuelqt58o7ijer8r1.apps.googleusercontent.com",
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        log("Google sign-in canceled");
        return null; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
      String uid = user.uid; // ✅ Get the UID from Firebase Auth

      // ✅ Check if user already exists in Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        // ✅ Save new Google sign-in user to Firestore
        await _firestore.collection('users').doc(uid).set({
          'uid': uid, // ✅ Store UID
          'first_name': user.displayName?.split(" ").first ?? '',
          'last_name': user.displayName?.split(" ").last ?? '',
          'email': user.email,
          'phone': user.phoneNumber ?? '',
          'profile_picture': user.photoURL ?? '',
          'created_at': FieldValue.serverTimestamp(),
          'provider': 'google',
        });
        log("✅ Google user details stored in Firestore!");
      } else {
        log("✅ Google user already exists in Firestore.");
      }
    }

      return user;
    } catch (e) {
      log("Google sign-in failed: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      log("Logout failed: $e");
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log("Password reset failed: $e");
      return false;
    }
  }

  User? get currentUser => _auth.currentUser;
}
