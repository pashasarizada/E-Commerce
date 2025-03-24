import 'package:flutter/material.dart';
import '../services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/loginViewModel.dart';
import 'main/mainPageView.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (loginVM.errorMessage != null)
              Text(loginVM.errorMessage!, style: TextStyle(color: Colors.red)),
            loginVM.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                await loginVM.login(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );

                if (loginVM.user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Giriş başarılı!")),
                  );
                  // TODO: Navigate to Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPageView()),
                  );                }
              },
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
