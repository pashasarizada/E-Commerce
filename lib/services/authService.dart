import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userModel.dart';
import '../models/userOrderModel.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> register({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      final UserCredential result =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      final uid = result.user!.uid;

      final newUser = UserModel(uid, userName, userEmail, []);

      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      return newUser;
    } catch (e) {
      print('Kayıt hatası: $e');
      return null;
    }
  }

  Future<UserModel?> login({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      final uid = result.user!.uid;

      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) return null;

      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Giriş hatası: $e');
      return null;
    }
  }

  // Çıkış Yap
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Şu anki kullanıcı
  User? get currentUser => _firebaseAuth.currentUser;

}
