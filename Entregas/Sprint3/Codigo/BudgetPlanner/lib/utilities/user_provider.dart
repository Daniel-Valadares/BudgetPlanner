import 'package:flutter/foundation.dart';
import 'package:budget_planner/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? getUser() {
    return this._user;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
