
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod{
 Future addUserInfoDatabase( String userId, Map<String, dynamic> userInfoMap) async{
   return FirebaseFirestore.instance.collection("user").doc(userId).set(userInfoMap);
  }
  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async{
    return FirebaseFirestore.instance.collection("user").where("username",isEqualTo: username).snapshots();

  }
}