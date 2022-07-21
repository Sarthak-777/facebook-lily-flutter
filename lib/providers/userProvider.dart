import 'package:facebook_lily/models/user.dart';
import 'package:facebook_lily/resources/authentication_firebase.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  dynamic? _user;

  User get getUser {
    return _user!;
  }

  Future<void> refreshUser() async {
    dynamic user = await AuthenticationFirebase().getCurrentUser();
    _user = user;
    // print(_user);
    notifyListeners();
  }
}
