import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:ecom/views/registerView.dart';
import 'package:ecom/views/loginView.dart';
import 'package:ecom/viewmodels/loginViewModel.dart';
import 'package:ecom/viewmodels/registerViewModel.dart';
import 'package:ecom/views/welcomeView.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('başarılı aga');
  } catch (e) {
    print('başarısız aga: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
      ],
      child: MaterialApp(
        home: WelcomeView(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}


/*Future<void> sendDummyUserToFirestore() async {
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
*/
