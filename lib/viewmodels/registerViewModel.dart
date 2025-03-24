import 'package:flutter/material.dart';
import '../services/authService.dart';
import '../models/userModel.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;
  UserModel? user;

  Future<void> register({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    user = await _authService.register(
      userName: userName,
      userEmail: userEmail,
      userPassword: userPassword,
    );

    if (user == null) {
      errorMessage = "Kayıt başarısız. Lütfen bilgileri kontrol et.";
    }

    isLoading = false;
    notifyListeners();
  }
}
