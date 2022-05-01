import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/resources/user_auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    var user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
