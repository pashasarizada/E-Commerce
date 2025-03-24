class ProductModel {
  final String productId;
  final String ownerId;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final DateTime createdAt;
  final String? location;
  final List<String> likedBy;

  ProductModel({
    required this.productId,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
    this.location,
    required this.likedBy,
  });

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
