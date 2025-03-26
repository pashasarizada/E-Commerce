import 'package:flutter/material.dart';
import 'package:ecom/widgets/appGradient.dart';
import 'package:ecom/services/userOrderService.dart';
import 'package:ecom/models/userOrderModel.dart';

class ProductDetailView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product['imageUrls'][0];
    final title = product['title'];
    final desc = product['description'];
    final price = product['price'];
    final location = product['location'];
    final owner = product['ownerEmail'] ?? 'Anonymous';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 10,
       // title: Text(title),
        leading: BackButton(color: Colors.white),),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.welcomeGreenGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "\$ $price",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text("📍 Konum: $location", style: const TextStyle(color: Colors.white,fontSize: 20)),
                const SizedBox(height: 4),
                Text("👤 İlan Sahibi: $owner", style: const TextStyle(color: Colors.white,fontSize: 20)),

                const SizedBox(height: 36),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(

                      onPressed: () async {
                        final productId = product['productId'] ?? product['id'] ?? '';

                        if (productId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product ID not found" ❌')),
                          );
                          return;
                        }

                        final orderItem = UserOrderModel(productId, 1);

                        await UserOrderService().addProductToUser(orderItem);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order has been successfully added! 🛒')),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text(
                      "Order now",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
