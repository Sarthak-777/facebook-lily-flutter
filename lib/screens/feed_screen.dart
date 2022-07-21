import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/widgets/feed_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: Colors.red[100],
      child: Column(
        children: [
          Container(
            color: kBgMainColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 1),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: const Text('Create a post',
                          style: TextStyle(color: kPrimaryColor)),
                    ),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      FeedCard(snap: snapshot.data.docs[index].data()),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
