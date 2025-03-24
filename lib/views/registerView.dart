import 'package:flutter/material.dart';
import '../services/authService.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userNameController = TextEditingController();

  final _authService = AuthService();

  bool _loading = false;
  String? _error;

  void _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final user = await _authService.register(
      userEmail: _userEmailController.text.trim(),
      userPassword: _userPasswordController.text.trim(),
      userName: _userNameController.text.trim(),
    );

    setState(() {
      _loading = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarılı! 👏')),
      );
    } else {
      setState(() {
        _error = 'Kayıt başarısız. Tekrar dene.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'İsim'),
            ),
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
              onPressed: _register,
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
