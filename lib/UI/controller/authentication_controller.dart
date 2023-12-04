import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_live_app/data.network_caller/models/user_model.dart';

class AuthenticationController{
  static String? token;
  static UserModel? user;


 static Future<void> saveUserInformation(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString("token", t);
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    token = t;
    user = model;
  }

  static Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    user = model;
  }

 static Future<void> initializeUserCache() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    UserModel.fromJson(jsonDecode(sharedPreferences.getString("user") ?? "{}"));
  }
  static Future<bool> checkAuthentication() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    if(token != null){
      await initializeUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthenticationData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }

}
