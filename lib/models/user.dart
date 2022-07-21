import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String photoUrl;
  final String bio;
  final List following;
  final List followers;
  final List friends;

  User(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.photoUrl,
      required this.following,
      required this.followers,
      required this.friends,
      required this.bio});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'following': following,
      'followers': followers,
      'friends': friends,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      friends: snapshot['friends'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
