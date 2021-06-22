

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messanger/HelperFunction/shared_preference.dart';
import 'package:messanger/services/database.dart';
import 'package:messanger/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async{
    return await _auth.currentUser;
  }

  singInWithGoogle(BuildContext context) async{
    final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    // ignore: unused_local_variable
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken:googleSignInAuthentication.idToken,
      accessToken:googleSignInAuthentication.accessToken ,
      
    );
    UserCredential result= await _firebaseauth.signInWithCredential(authCredential);
    User? userDetail = result.user;
    // ignore: unnecessary_null_comparison
    if(result != null){
      sharedPreferenceHelper().saveUserEmail(userDetail!.email.toString());
      sharedPreferenceHelper().saveUserId(userDetail.uid);
      sharedPreferenceHelper().saveDisplayName(userDetail.displayName.toString());
      sharedPreferenceHelper().saveUserName(userDetail.email!.replaceAll("@gmail.com", ""));
      sharedPreferenceHelper().saveUserProfile(userDetail.photoURL.toString());
      Map<String, dynamic> userInfoMap={
        "email":userDetail.email,
        "username":userDetail.email!.replaceAll("@gmail.com", ""),
        "name":userDetail.displayName,
        "imgUrl":userDetail.photoURL,
      };
      DatabaseMethod().addUserInfoDatabase(userDetail.uid, userInfoMap).then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Homepage()));
      });
    }

  }
  Future signOut() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
     await _auth.signOut();
     
  }
}