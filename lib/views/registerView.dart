import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/registerViewModel.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final registerVM = Provider.of<RegisterViewModel>(context);
    final _userNameController = TextEditingController();
    final _userEmailController = TextEditingController();
    final _userPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'İsim'),
            ),
            TextField(
              controller: _userEmailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _userPasswordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (registerVM.errorMessage != null)
              Text(registerVM.errorMessage!, style: const TextStyle(color: Colors.red)),
            registerVM.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                await registerVM.register(
                  userName: _userNameController.text.trim(),
                  userEmail: _userEmailController.text.trim(),
                  userPassword: _userPasswordController.text.trim(),
                );

                if (registerVM.user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kayıt başarılı! 👏')),
                  );
                  // TODO: Navigate to home
                }
              },
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
