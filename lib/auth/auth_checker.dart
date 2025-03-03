import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/login.dart';

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()), // Show loading screen
          );
        }
        if (snapshot.hasData) {
          return HomePage(); // User is logged in
        } else {
          return LoginPage(); // User is logged out
        }
      },
    );
  }

  /// ✅ Function to check authentication status for SplashScreen
  static Future<bool> isUserLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;  // Returns true if user is logged in
  }
}
