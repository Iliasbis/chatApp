// ignore_for_file: file_names

import 'package:chat_app/component/DefaultSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseAuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _fireStore.collection("users").doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'email': email,
      });
      return credential.user;
    } on FirebaseAuthException catch (e) {
      DefaultSnackBar.showSnackBarError(
          context, e.message.toString(), Colors.red);
    }
    return null;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<User?> signinWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _fireStore.collection("users").doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return credential.user;
    } on FirebaseAuthException catch (e) {
      DefaultSnackBar.showSnackBarError(
          context, e.message.toString(), Colors.red);
    }
    return null;
  }
}
