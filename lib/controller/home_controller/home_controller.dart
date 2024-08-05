import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class HomeController extends ChangeNotifier {
  HomeController();

  bool isLoading = false;
  UserModel? currentUser;
  void loading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
