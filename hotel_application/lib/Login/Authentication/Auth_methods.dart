import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_application/Screens/Admin/AdminHomeScreen.dart';
import 'package:hotel_application/Screens/Admin/Dashboard.dart';
import 'package:hotel_application/Screens/User/home_screen.dart';

import '../../Components/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);
  //STATE PERSISTENCE
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  //EMAIL SIGN UP

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //EMAIL LOGIN
  Future<void> loginUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var firebaseUser = await FirebaseAuth.instance.currentUser!;

      if (firebaseUser.uid == "vUs1EdGl3iNVIrobfANdPVO4rOk2") {
        // tried to find admin with its uid
        print("--------------admin");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AdminHomeScreen();
            },
          ),
        );
      } else {
        if (!result.currentUser!.emailVerified) {
          await sendEmailVerification(context);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // ignore: unused_local_variable
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // ignore: unused_local_variable
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {}
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //EMAIL VEREFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
  //Sing out

  Future<void> singOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
