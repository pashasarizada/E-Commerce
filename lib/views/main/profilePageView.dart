import 'package:flutter/material.dart';
import 'package:ecom/widgets/appGradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecom/services/profileService.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final profileService = ProfileService();

    return  Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(gradient: AppGradients.welcomeGreenGradient),
        child: Column(
          children: [
            FutureBuilder<Map<String?,dynamic>?>(
                future: profileService.getUserById(currentUser?.uid),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text("User data not found", style: TextStyle(color: Colors.white));
                  }
                  final userData = snapshot.data!;
                  return Column(
                    children: [
                      Icon(Icons.account_circle, size: 80, color: Colors.white70),
                      const SizedBox(height: 16),
                      Text("Name: ${userData['userName'] ?? 'N/A'}", style: TextStyle(color: Colors.white, fontSize: 18)),
                      Text("Email: ${userData['userEmail'] ?? 'N/A'}", style: TextStyle(color: Colors.white, fontSize: 18)),

                    ],
                  );
                }
            )
          ],
        ),
        ),
       )
    );
  }
}
