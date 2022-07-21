import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_lily/models/user.dart' as model;
import 'package:facebook_lily/resources/storage_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthenticationFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required Uint8List photo,
      required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    String res = 'Some Error occured';
    try {
      if (photo != null ||
          firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String fileDownloadUrl =
            await storageFirebase().storeImage(photo, 'Profile Picture', false);
        model.User userData = model.User(
            uid: user.user!.uid,
            firstName: firstName,
            lastName: lastName,
            email: email,
            photoUrl: fileDownloadUrl,
            following: [],
            followers: [],
            friends: [],
            bio: '');
        await firestore
            .collection('users')
            .doc(user.user!.uid)
            .set(userData.toJson());
        res = 'success';
        return res;
      }
    } catch (e) {
      res = e.toString();
      print(res);
      return res;
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
        return res;
      }
    } catch (e) {
      res = e.toString();
      return res;
    }
    return res;
  }

  Future getCurrentUser() async {
    try {
      User user = await _auth.currentUser!;
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      return model.User.fromSnap(snapshot);
    } catch (e) {
      return e;
    }
  }

  Future<bool> handleLikes(String uid, String postId, List likes) async {
    if (likes.contains(uid)) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
      return false;
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
      return true;
    }
  }
}
