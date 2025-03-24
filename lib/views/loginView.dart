import 'package:flutter/material.dart';
import '../services/authService.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final _authService = AuthService();

  bool _loading = false;
  String? _error;

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final user = await _authService.login(
      userEmail: _userEmailController.text.trim(),
      userPassword: _userPasswordController.text.trim(),
    );

    setState(() {
      _loading = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı! ✅')),
      );
      // TODO: Navigate to Home Page
    } else {
      setState(() {
        _error = 'Giriş başarısız. Bilgileri kontrol et.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _userEmailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _userPasswordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _login,
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
