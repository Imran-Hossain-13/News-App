import 'dart:async';
import 'package:get/get.dart';
import 'package:news/res/routes/routes_name.dart';
import '../preferences/login_pref.dart';

class SplashServices {
  LoginPreferences loginPreferences = LoginPreferences();
  void isLogin() async{
    loginPreferences.getPreferences().then((value) {
      Timer(const Duration(seconds: 3), () {
        if(value == true){
          // Get.toNamed(RoutesName.homeScreen);
          Get.offAndToNamed(RoutesName.channelSelectorScreen);
        }else{
          Get.offAndToNamed(RoutesName.loginScreen);
        }
      });
    });
  }

}