
class UserOrderModel {
  final String productId;
  final int quantity;

  UserOrderModel(this.productId, this.quantity);

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory UserOrderModel.fromMap(Map<String, dynamic> map) {
    return UserOrderModel(
      map['productId'],
      map['quantity'],
    );
  }
}
