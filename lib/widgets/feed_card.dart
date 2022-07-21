import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/resources/firestore_methods.dart';
import 'package:facebook_lily/screens/comments_screen.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/widgets/drag_to_pop_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:facebook_lily/resources/authentication_firebase.dart';

class FeedCard extends StatefulWidget {
  final snap;
  const FeedCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool isLiked = false;
  String commentsCount = '0';

  handleLikeButton(uid, postId, likes) async {
    bool liked = await AuthenticationFirebase().handleLikes(uid, postId, likes);
    setState(() {
      isLiked = liked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommentsLength();
  }

  Future<void> CommentsLength() async {
    String count = await FirestoreMethods().commentsCount(widget.snap);
    print(count);
    setState(() {
      commentsCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        color: kBgMainColor,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.snap['profilePic']),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.snap['firstName']} ${widget.snap['lastName']}',
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(
                              widget.snap['datePosted'].toDate(),
                            ),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 244, 141, 175),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_circle_outline_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Text(widget.snap['description'],
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.black87, fontSize: 14)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Image.network(
                widget.snap['postUrl'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.snap['likes'].length.toString()} likes',
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: kPrimaryColor,
                      ),
                      children: [
                        TextSpan(text: '$commentsCount comments'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: kPrimaryColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () => handleLikeButton(
                      user.uid, widget.snap['postId'], widget.snap['likes']),
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(Icons.thumb_up)
                      : const Icon(Icons.thumb_up_outlined),
                  label: const Text('like'),
                  style: TextButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    ImageViewerPageRoute(
                        builder: (context) =>
                            CommentsScreen(snap: widget.snap)),
                  ),
                  icon: Icon(Icons.comment_outlined),
                  label: Text('comment'),
                  style: TextButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined),
                  label: Text('share'),
                  style: TextButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
