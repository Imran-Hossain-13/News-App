import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences{
  void setPreferences(String message)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isLogin", true);
  }

  Future<bool> getPreferences()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool("isLogin");
    if(isLogin == null || isLogin.toString().isEmpty){
      return false;
    }else{
      return true;
    }
  }

  void clearPreferences()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}