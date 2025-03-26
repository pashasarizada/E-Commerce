import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecom/models/userOrderModel.dart';

class UserOrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addProductToUser(UserOrderModel orderItem) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    final userDocRef = _firestore.collection('users').doc(currentUser.uid);

    try {
      final userSnapshot = await userDocRef.get();

      final List<dynamic> currentOrdersRaw = userSnapshot.data()?['userOrders'] ?? [];
      final List<Map<String, dynamic>> currentOrders = currentOrdersRaw.map((e) => Map<String, dynamic>.from(e)).toList();

      bool productExists = false;

      final updatedOrders = currentOrders.map((order) {
        if (order['productId'] == orderItem.productId) {
          productExists = true;
          return {
            'productId': order['productId'],
            'quantity': order['quantity'] + orderItem.quantity,
          };
        }
        return order;
      }).toList();

      if (!productExists) {
        updatedOrders.add(orderItem.toMap());
      }

      await userDocRef.update({
        'userOrders': updatedOrders,
      });
    } catch (e) {
      print('Sepete ekleme hatası: $e');
    }
  }

}
