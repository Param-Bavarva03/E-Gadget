import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants/constants.dart';
import 'package:mad_project/models/user_model/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return true;

      // ignore: empty_catches
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  Future<bool> SignUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel =
          UserModel(id: userCredential.user!.uid, name: name, email: email, image: null);
      // ignore: use_build_context_synchronously

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return true;

      // ignore: empty_catches
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
      return false;
    }
  }
  void signOut() async
  {
    await _auth.signOut();
  }

Future<bool> changePassword(String password, BuildContext context) async {
  try {
    showLoaderDialog(context);
    await _auth.currentUser!.updatePassword(password);
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    showMessage("Password Changed");
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Close the current screen
    return true;
  } on FirebaseAuthException catch (e) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    showMessage(e.code.toString());
    return false;
  }
}

}
