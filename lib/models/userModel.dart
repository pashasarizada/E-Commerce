import 'userOrderModel.dart';

class UserModel {
  final String userId;
  final String userName;
  final String userEmail;
  final List<UserOrderModel> userOrders;

  UserModel(this.userId, this.userName, this.userEmail, this.userOrders);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userOrders': userOrders.map((order) => order.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['userId'],
      map['userName'],
      map['userEmail'],
      (map['userOrders'] as List<dynamic>)
          .map((order) => UserOrderModel.fromMap(order))
          .toList(),
    );
  }
}
