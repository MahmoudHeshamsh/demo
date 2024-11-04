import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModels? currentUser;

  void updateUser(UserModels? user) {
    currentUser = user;
    notifyListeners();
  }
}
