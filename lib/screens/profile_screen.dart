import 'package:facebook_lily/screens/login_screen.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  firebaseLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfilePicBgPicWidget(),
          const Text('Sarthak Bajracharya',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                      onPressed: () {},
                      child: const Text('Edit Profile')),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                      ),
                      onPressed: () => firebaseLogout(context),
                      child: const Icon(Icons.logout_outlined)),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                color: Color.fromARGB(255, 247, 184, 206),
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.home_filled,
                          size: 25, color: kPrimaryColor),
                    ),
                    TextSpan(
                        text: '  Lives in ',
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    TextSpan(
                      text: 'Lalitpur, Nepal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.location_on,
                          size: 25, color: kPrimaryColor),
                    ),
                    TextSpan(
                        text: '  from ',
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    TextSpan(
                      text: 'Lalitpur, Nepal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfilePicBgPicWidget extends StatelessWidget {
  const ProfilePicBgPicWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1658089676988-c6e8e46d3d1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'))),
                ),
              ),
            ),
            const SizedBox(height: 70.0)
          ],
        ),
        Positioned(
          bottom: 5.0,
          left: 110.0,
          child: Container(
            width: 160.0,
            height: 160.0,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1658208309901-2eaad3b5d118?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(
                color: kBgMainColor,
                width: 4.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
