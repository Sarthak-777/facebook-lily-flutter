import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_lily/functions/pick_image.dart';
import 'package:facebook_lily/models/post.dart';
import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/resources/storage_firebase.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController descriptionController = TextEditingController();
  Uint8List? _file;

  dialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                child: const Text('Take a picture'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void postButton(String uid, Uint8List file, String description,
      String firstName, String lastName, String profilePic) async {
    String res = 'Some Error Occured';
    try {
      String fileUrl = await storageFirebase().storeImage(file, 'posts', true);
      print(profilePic);
      String postId = Uuid().v1();
      Post post = Post(
          datePosted: DateTime.now(),
          description: description,
          firstName: firstName,
          lastName: lastName,
          likes: [],
          postId: postId,
          postUrl: fileUrl,
          uid: uid,
          type: 'photo',
          profilePic: profilePic);
      await FirebaseFirestore.instance.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
      showSnackBar(res, context);
      setState(() {
        _file = null;
      });
      // await FirebaseFirestore.instance.collection('posts').doc(uid).
    } catch (e) {
      res = e.toString();
      showSnackBar(res, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Upload a photo',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              IconButton(
                  onPressed: () => dialogBox(context),
                  icon: const Icon(
                    Icons.upload_outlined,
                    color: kPrimaryColor,
                    size: 30.0,
                  ))
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('${user.firstName} ${user.lastName}'),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your description',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 5.0, 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurpleAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    alignment: Alignment.bottomRight,
                    onPressed: () => postButton(
                        user.uid,
                        _file!,
                        descriptionController.text,
                        user.firstName,
                        user.lastName,
                        user.photoUrl),
                    icon: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 350.0,
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 450 / 430,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
