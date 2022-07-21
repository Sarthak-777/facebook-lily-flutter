import 'package:facebook_lily/resources/authentication_firebase.dart';
import 'package:facebook_lily/screens/dashboard_screen.dart';
import 'package:facebook_lily/screens/signup_screen.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/widgets/horizontal_line.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void SignInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthenticationFirebase().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      _isLoading = false;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    } else {
      print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBgMainColor,
        child: Column(
          children: [
            Image.asset(
              'assets/Lily-logo.png',
              fit: BoxFit.cover,
              height: 250.0,
              width: double.infinity,
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Phone number or email address',
                        hintStyle: TextStyle(color: Colors.pink.shade200),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent, width: 2.0),
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.pink.shade200),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepPurpleAccent, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28.0),
                  InkWell(
                    onTap: SignInUser,
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
                          : const Text('Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              )),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Forgotten Password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 254, 113, 160),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const HorizontalOrLine(label: 'OR', height: 120.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const ShapeDecoration(
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                      child: const Text('Create New Facebook Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
