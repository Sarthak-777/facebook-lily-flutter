import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/resources/firestore_methods.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavPostCommentField extends StatelessWidget {
  final snap;

  const BottomNavPostCommentField({
    Key? key,
    required TextEditingController textController,
    required this.snap,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  submitComment(text, user) async {
    String response = await FirestoreMethods().postComments(snap, text, user);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 228, 184, 189),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 35.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.deepOrange[50],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintText: 'Write a comment',
                      hintStyle: const TextStyle(
                        color: kPrimaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      )),
                ),
              ),
              IconButton(
                onPressed: () => submitComment(_textController.text, user),
                icon: const Icon(Icons.send, color: kPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
