import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> userSignUp({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List image,
  }) async {
    String res = "";
    try {
      if (email.isEmpty ||
          username.isEmpty ||
          password.isEmpty ||
          bio.isEmpty) {
        res = "Fill all the fields first";
        if (kDebugMode) {
          print(res);
        }
      } else {
        var cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        var uid = _auth.currentUser!.uid;
        var imageUrl = await StorageMethods()
            .saveimage(child: 'profilePictures', file: image, isPost: false);

        UserModel user = UserModel(
            username: username,
            email: email,
            uid: uid,
            bio: bio,
            followers: [],
            following: [],
            profilePic: imageUrl);

        _firestore.collection('users').doc(cred.user!.uid).set(user.userToDB());
        res = "Sucess";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    String res = "";
    try {
      if (email.isEmpty) {
        res = "Please, fill in your email";
      } else if (password.isEmpty) {
        res = "Pleas, fill in your password";
      } else {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  Future<UserModel> getUserDetails() async {
    var user = _auth.currentUser!.uid;
    var snap = await _firestore.collection('users').doc(user).get();
    return UserModel.userFromDB(snap);
  }
}
