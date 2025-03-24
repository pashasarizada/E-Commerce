class ProductModel {
  final String productId;
  final String ownerId;
  final String ownerEmail;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final DateTime createdAt;
  final String? location;
  final List<String> likedBy;


  ProductModel(this.productId, this.ownerId, this.ownerEmail, this.title,
      this.description, this.price, this.imageUrl, this.createdAt,
      this.location, this.likedBy);

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'location': location,
      'likedBy': likedBy,

    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      ownerId: map['ownerId'],
      ownerEmail: map['ownerEmail'],
      title: map['title'],
      description: map['description'],
      price: map['price'].toDouble(),
      imageUrl: map['imageUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      location: map['location'],
      likedBy: List<String>.from(map['likedBy'] ?? []),
    );
  }
}
