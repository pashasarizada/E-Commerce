import 'package:flutter/material.dart';
import 'package:ecom/widgets/appGradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecom/services/profileService.dart';
import 'package:ecom/views/main/productDetailView.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final profileService = ProfileService();

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppGradients.welcomeGreenGradient),
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Map<String?, dynamic>?>(
                future: profileService.getUserById(currentUser?.uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text("User Info doesn't exist", style: TextStyle(color: Colors.white));
                  }
                  final userData = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.account_circle, size: 80, color: Colors.white70),
                      const SizedBox(height: 12),
                      Text("👤 ${userData['userName'] ?? 'N/A'}",
                          style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                      Text("📧 ${userData['userEmail'] ?? 'N/A'}",
                          style: const TextStyle(color: Colors.white, fontSize: 26)),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: profileService.getUserOrderProducts(currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("🛒 You don't have any order", style: TextStyle(color: Colors.white));
                  }
                  final orders = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("🛍️ Your orders:",
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...orders.map((order) {
                        final imageUrl = order['imageUrls'][0];
                        final title = order['title'];
                        final quantity = order['quantity'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailView(product: order),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22)),
                                      Text("Quantity: $quantity", style: const TextStyle(color: Colors.white70)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
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
