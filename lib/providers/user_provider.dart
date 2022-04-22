import 'package:flutter/widgets.dart';
import 'package:instagran_tute/resources/auth_methods.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners(); //ó thông báo cho người nghe của nó
  }
}
