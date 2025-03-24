import 'package:flutter/material.dart';
import 'loginPageView.dart';
import 'registerPageView.dart';
import 'package:ecom/widgets/customButton.dart';
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.amberAccent),
              const SizedBox(height: 20),
              Text(
                'Welcome to E-Commerce App!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Register',
                color: Colors.amberAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterView()),
                  );
                },
              ),
              const SizedBox(height: 18),
              CustomButton(
                text: 'Log in',
                textColor: Colors.amberAccent,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
