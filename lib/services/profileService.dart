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



}