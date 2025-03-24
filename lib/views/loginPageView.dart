import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/loginViewModel.dart';
import '../views/main/mainPageView.dart';
import '../widgets/customButton.dart';
import 'package:ecom/widgets/appGradient.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.registerGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Icon(Icons.lock_outline, size: 80, color: Colors.white),
                    const SizedBox(height: 20),
                    const Text(
                      'Log in ',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please login to your account',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),

                    // Email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),

                    // Password
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),

                    if (loginVM.errorMessage != null)
                      Text(
                        loginVM.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    loginVM.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      text: 'Log in',
                      color: Colors.white,
                      textColor: Colors.green,
                      borderColor: Colors.white,
                      onPressed: () async {
                        await loginVM.login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (loginVM.user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login successful ✅")),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const MainPageView()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
