import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/userModel.dart';
class ProfileService{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String,dynamic>?> getUserById(String? uid) async{

    try{
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if(userDoc.exists){
        return userDoc.data() as Map<String,dynamic>;
      }
      else{
        print('kullanici bulunamadi aga');
        return null;
      }
    }catch (e) {
      print("Error aga : $e");
      return null;
    }

  }

  Future<List<Map<String, dynamic>>> getUserOrders(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    final orders = userDoc.data()?['userOrders'] ?? [];

    return List<Map<String, dynamic>>.from(
      orders.map((e) => Map<String, dynamic>.from(e)),
    );
  }
  Future<List<Map<String, dynamic>>> getUserOrderProducts(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    final ordersRaw = userDoc.data()?['userOrders'] ?? [];

    final List<Map<String, dynamic>> orders = List<Map<String, dynamic>>.from(
      ordersRaw.map((e) => Map<String, dynamic>.from(e)),
    );

    List<Map<String, dynamic>> fullProducts = [];

    for (final order in orders) {
      final productId = order['productId'];
      final quantity = order['quantity'];

      final productDoc = await _firestore.collection('products').doc(productId).get();
      final productData = productDoc.data();

      if (productData != null) {
        fullProducts.add({
          'quantity': quantity,
          'productId': productId,
          ...productData,
        });
      }
    }

    return fullProducts;
  }


}