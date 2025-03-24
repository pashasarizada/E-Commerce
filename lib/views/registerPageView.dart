import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/registerViewModel.dart';
import '../widgets/appGradient.dart'; 
import '../widgets/customButton.dart';
import 'package:ecom/views/welcomePageView.dart';

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
          gradient: AppGradients.registerGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back,size: 31),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    TextField(
                      controller: _userNameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _userEmailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _userPasswordController,
                      decoration: const InputDecoration(labelText: 'Password'),
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
                         Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const WelcomeView()),
                         );
                        }
                      },
                      height: 50,
                      color: Colors.green,
                      textColor: Colors.white,
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
