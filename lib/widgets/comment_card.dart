import 'package:facebook_lily/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.snap['profilePic']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.snap['firstName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBgMainColor,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        widget.snap['comment'],
                        style: const TextStyle(color: kBgMainColor),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                DateFormat.Hm().format(
                  widget.snap['date'].toDate(),
                ),
                // DateFormat.HOUR24().format(
                //   widget.snap['date'].toDate(),
                // ),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.red[400],
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
