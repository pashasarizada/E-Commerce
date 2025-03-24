import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
     print('basarili aga');
  } catch  (e){
     print('basarisiz aga');
  }
  await sendDummyUserToFirestore();

  runApp( MyApp());

}
Future<void> sendDummyUserToFirestore() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final dummyUser = {
    'userId': 'user_004',
    'userName': 'Maraz Ali',
    'userEmail': 'marazali@email.com',
    'createdAt': Timestamp.now(),
    'userOrder': [
      {
        'productId': 'prod_123',
        'quantity': 8,
      },
      {
        'productId': 'prod_456',
        'quantity': 2,
      },
    ],
  };

  await firestore.collection('users').doc(dummyUser['userId'] as String).set(dummyUser);
  print("Kullanıcı gönderildi.");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Firestore Veri Gönderildi')),
      ),
    );
  }
}
