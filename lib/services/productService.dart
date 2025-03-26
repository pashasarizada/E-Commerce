import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProduct({
    required String title,
    required String description,
    required double price,
    required List<String> imageUrls,
    String? location,
  }) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception("Kullanıcı oturumu yok");
    }

    final docRef = _firestore.collection('products').doc();

    await docRef.set({
      'productId': docRef.id,
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.now(),
      'ownerId': currentUser.uid,
      'ownerEmail': currentUser.email,
    });
  }
}
