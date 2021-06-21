
import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferenceHelper{
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERName";
  static String userDisplayName = "USERDispalyName";
  static String userEmailKey = "USEREmailKey";
  static String userProfileKey = "USERProfleKey";
//save user Data
  Future<bool> saveUserName(String getUserName) async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
  }
  Future<bool> saveUserEmail(String getUserEmail) async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getUserEmail);
  }
  Future<bool> saveUserId(String getUserId) async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserId);
  }
  Future<bool> saveDisplayName(String getDisplayName) async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getDisplayName);
  }
  Future<bool> saveUserProfile(String getUserProfile) async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserProfile);
  }
//get data
  Future<String?> getUserName() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }
  Future<String?> getUserEmail() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }
  Future<String?> getUserId() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }
  Future<String?> getDisplayName() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.getString(userDisplayName);
  }
  Future<String?> getUserPrifile() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.getString(userProfileKey);
  }
}