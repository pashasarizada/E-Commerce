import 'package:flutter/material.dart';
import 'loginPageView.dart';
import 'registerPageView.dart';
import 'package:ecom/widgets/customButton.dart';
import 'package:ecom/widgets/lowerHalfEllipse.dart';
import 'package:ecom/widgets/appGradient.dart';
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Üst daire
          Positioned(
            top: 0,
            right: 0,
            child: LowerHalfEllipse(width: 870, height: 150,  gradient: AppGradients.welcomeGreenGradient,),
          ),
          // Alt daire
          Positioned(
            bottom: -120,
            left: 0,
            child: LowerHalfEllipse(width: 850, height: 300,  gradient: AppGradients.welcomeGreenGradient,),
          ),


          // İÇERİK
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.green),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to E-Commerce App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Register',
                    textSize: 20,
                    color: Colors.green,
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
                    textSize: 20,
                    textColor: Colors.green,
                    borderColor: Colors.green,
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
        ],
      ),
    );
  }
}
