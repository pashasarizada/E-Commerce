
class UserOrder{

  final String productId;
  final int quantity;

  UserOrder(this.productId, this.quantity);

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory UserOrder.fromMap(Map<String, dynamic> map) {
    return UserOrder(
      map['productId'],
      map['quantity'],
    );
  }
}