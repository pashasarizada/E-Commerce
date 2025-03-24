import 'package:flutter/material.dart';
import '../services/authService.dart';
import '../models/userModel.dart';

class LoginViewModel extends ChangeNotifier{

  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? errorMessage;
  UserModel? user;


  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    user = await _authService.login(
      userEmail: email,
      userPassword: password,
    );

    if (user == null) {
      errorMessage = "Giriş başarısız. Bilgileri kontrol et.";
    }

    isLoading = false;
    notifyListeners();
  }


}