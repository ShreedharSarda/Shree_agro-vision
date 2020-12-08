import 'package:drone/pages/home_page.dart';
import 'package:drone/pages/login_page.dart';
import 'package:drone/shared/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  // Intilize the flutter app
  FirebaseApp firebaseApp;
  User firebaseUser;
  FirebaseAuth firebaseAuth;

  Future<void> initializeFirebaseApp() async {
    firebaseApp = await Firebase.initializeApp();
  }

  Future<Widget> checkUserLoggedIn() async {
    if (firebaseApp == null) {
      await initializeFirebaseApp();
    }
    if (firebaseAuth == null) {
      firebaseAuth = FirebaseAuth.instance;
      update();
    }
    if (firebaseAuth.currentUser == null) {
      return LoginPage();
    } else {
      firebaseUser = firebaseAuth.currentUser;
      update();
      return HomePage();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Show loading screen till we complete our login workflow
      Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
      // for flutter fire we need to maker sure Firebase is initilzed before dong any auth related activity
      await initializeFirebaseApp();
      // Create Firebase auth for storing auth related info such as logged in user etc.
      firebaseAuth = FirebaseAuth.instance;
      // Start of google sign in workflow
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredentialData =
          await FirebaseAuth.instance.signInWithCredential(credential);
      firebaseUser = userCredentialData.user;
      // update the state of controller variable to be reflected throughout the app
      update();
      Get.back();
      Get.to(HomePage());
    } catch (ex) {
      Get.back();
      // Show Error if we catch any error
      Get.snackbar('Sign In Error', 'Error Signing in',
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
  }

  Future<void> signOut() async {
    // Show loading widget till we sign out
    Get.dialog(Center(child: LoadingWidget()), barrierDismissible: false);
    await firebaseAuth.signOut();
    Get.back();
    // Navigate to Login again
    Get.offAll(LoginPage());
  }
}
