import 'package:facebook_lily/screens/feed_screen.dart';
import 'package:facebook_lily/screens/friend_screen.dart';
import 'package:facebook_lily/screens/profile_screen.dart';
import 'package:facebook_lily/screens/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const FriendScreen(),
  const Center(child: Text('Watch')),
  const Center(child: Text('Shop')),
  const UploadScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
