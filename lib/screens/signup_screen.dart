import 'dart:typed_data';

import 'package:facebook_lily/functions/pick_image.dart';
import 'package:facebook_lily/resources/authentication_firebase.dart';
import 'package:facebook_lily/screens/dashboard_screen.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthenticationFirebase().signUpUser(
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        password: _passwordController.text,
        photo: _image!);
    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgMainColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Create Account',
          style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 18.0),
        ),
        backgroundColor: kBgMainColor,
        elevation: 1,
        shadowColor: kPrimaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            InkWell(
              onTap: selectImage,
              child: _image == null
                  ? const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 182, 204),
                      radius: 65,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/no-pp.png'),
                        radius: 61.0,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 182, 204),
                      radius: 65,
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(_image!),
                        radius: 61.0,
                      ),
                    ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputStyling('First Name'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                      controller: _lastNameController,
                      decoration: InputStyling('Last Name')),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
                controller: _emailController,
                decoration: InputStyling('Email Address')),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputStyling('Password'),
            ),
            const SizedBox(
              height: 50.0,
            ),
            InkWell(
              onTap: signUpUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                decoration: const ShapeDecoration(
                  color: Color.fromARGB(255, 255, 106, 155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 246, 219, 228),
                        ),
                      )
                    : const Text('Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration InputStyling(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.pink.shade200),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
      ),
    );
  }
}
