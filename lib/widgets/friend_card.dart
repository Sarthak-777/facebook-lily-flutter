import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/resources/firestore_methods.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendCard extends StatelessWidget {
  final snap;
  const FriendCard({Key? key, required this.snap}) : super(key: key);

  addFriend(uid, friendUid) async {
    await FirestoreMethods().updateFriend(uid, friendUid);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    print(snap['uid']);

    return snap['uid'] == user.uid
        ? const SizedBox()
        : Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                    snap['photoUrl'],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${snap['firstName']} ${snap['lastName']}'),
                    // const SizedBox(height: 10.0),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                            primary: kPrimaryColor,
                          ),
                          onPressed: () => addFriend(user.uid, snap['uid']),
                          child: const Text(
                            'Add Friend',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0),
                            primary: Colors.deepOrange[100],
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Remove',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
