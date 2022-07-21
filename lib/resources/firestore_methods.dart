import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<String> postComments(snap, text, user) async {
    String res = 'Some error occured';
    try {
      String commentId = Uuid().v1();
      await firestore
          .collection('posts')
          .doc(snap['postId'])
          .collection('comments')
          .doc(commentId)
          .set({
        'profilePic': user.photoUrl,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'comment': text,
        'commentId': commentId,
        'date': DateTime.now(),
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> commentsCount(snap) async {
    String count = '0';
    var snapshots = await firestore
        .collection('posts')
        .doc(snap['postId'])
        .collection('comments')
        .get();
    int data = snapshots.docs.length;
    count = data.toString();
    return count;
  }

  Future<String> updateFriend(uid, friendUid) async {
    String res = 'Some error occured';
    try {
      print(friendUid);
      print(uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendUid)
          .update({
        'friends': FieldValue.arrayUnion([uid]),
      });
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'friends': FieldValue.arrayUnion([friendUid]),
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
      print(e);
    }

    return res;
  }
}
