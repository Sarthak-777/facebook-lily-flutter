import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';

import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/widgets/comment_bot_nav.dart';
import 'package:facebook_lily/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  final snap;

  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    User user = Provider.of<UserProvider>(context).getUser;
    double position;

    return GestureDetector(
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: snap['likes'].contains(user.uid)
                  ? Text(
                      'You and ${snap['likes'].length - 1} other likes',
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    )
                  : Text(
                      '${snap['likes'].length} likes',
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
              backgroundColor: kBgMainColor,
              elevation: 0,
              actions: [
                snap['likes'].contains(user.uid)
                    ? const Icon(Icons.thumb_up, color: kPrimaryColor)
                    : const Icon(Icons.thumb_up_outlined, color: kPrimaryColor),
                const SizedBox(
                  width: 10.0,
                )
              ],
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(snap['postId'])
                  .collection('comments')
                  .orderBy('date', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => CommentCard(
                    snap: ((snapshot.data! as dynamic).docs[index].data()),
                  ),
                );
              },
            ),
            bottomNavigationBar: BottomNavPostCommentField(
                textController: _textController, snap: snap),
          ),
        ),
      ),
      onVerticalDragUpdate: (DragUpdateDetails details) {
        position =
            MediaQuery.of(context).size.height - details.globalPosition.dy;
        print(position);
        if (position > 600) {
          Navigator.maybePop(context);
        }
      },

      // onTap: () {
      //   Navigator.maybePop(context);
      // },
    );
  }
}
