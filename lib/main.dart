import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/screens/dashboard_screen.dart';
import 'package:facebook_lily/screens/login_screen.dart';
import 'package:facebook_lily/screens/signup_screen.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: kBgMainColor,
        ),
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser != null
            ? const DashboardScreen()
            : const LoginScreen(),
      ),
    );
  }
}
