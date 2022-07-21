import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/widgets/friend_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add a Friend',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').where(
                  'friends',
                  whereNotIn: [
                    [user.uid]
                  ],
                ).snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  print(snapshot.data!.docs[0].data());
                  return Container(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => FriendCard(
                            snap: snapshot.data!.docs[index].data())),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
