

class User {
  late final String userId;
  late final String userName;
  late final String userEmail;
  late final List<UserOrder> userOrder;

  User(this.userId, this.userName, this.userEmail),this.userOrders;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userOrders': userOrders.map((order) => order.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['userId'],
      map['userName'],
      map['userEmail'],
      (map['userOrders'] as List<dynamic>)
          .map((order) => UserOrder.fromMap(order))
          .toList(),
    );
  }
}