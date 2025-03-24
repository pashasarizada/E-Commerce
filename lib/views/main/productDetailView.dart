import 'package:flutter/material.dart';

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
    final owner = product['ownerEmail'] ?? 'Bilinmiyor';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 16),
            Text("\$ $price", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(desc),
            const SizedBox(height: 8),
            Text("Konum: $location"),
            const SizedBox(height: 8),
            Text("İlan Sahibi: $owner"),
          ],
        ),
      ),
    );
  }
}
