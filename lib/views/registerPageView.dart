import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/registerViewModel.dart';
import '../widgets/appGradient.dart';
import '../widgets/customButton.dart';
import '../views/welcomePageView.dart';
import '../widgets/customTextField.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final registerVM = Provider.of<RegisterViewModel>(context);
    final _userNameController = TextEditingController();
    final _userEmailController = TextEditingController();
    final _userPasswordController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.welcomeGreenGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Register to get started",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),

                    CustomTextField(
                      hintText: 'Full Name',
                      controller: _userNameController,
                      inputType: TextInputType.name,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 15),

                    // 📧 Email
                    CustomTextField(
                      hintText: 'Email',
                      controller: _userEmailController,
                      inputType: TextInputType.emailAddress,
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 15),

                    // 🔒 Password
                    CustomTextField(
                      hintText: 'Password',
                      controller: _userPasswordController,
                      inputType: TextInputType.visiblePassword,
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),

                    if (registerVM.errorMessage != null)
                      Text(
                        registerVM.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 12),

                    registerVM.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      text: "Register",
                      onPressed: () async {
                        await registerVM.register(
                          userName: _userNameController.text.trim(),
                          userEmail: _userEmailController.text.trim(),
                          userPassword: _userPasswordController.text.trim(),
                        );

                        if (registerVM.user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registration completed! 👏')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const WelcomeView()),
                          );
                        }
                      },
                      height: 50,
                      color: Colors.white,
                      textColor: Colors.green,
                      borderColor: Colors.white,
                      borderRadius: 12,
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
