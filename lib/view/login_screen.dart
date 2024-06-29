import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/res/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/preferences/login_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumber = TextEditingController();
  LoginPreferences loginPreferences = LoginPreferences();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: size.height * 1,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text("DN",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                            ),
                            const SizedBox(width: 5,),
                            const Column(
                              children: [
                                Text("DAILY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Text("NEWS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Text("Get nearby news on top",style: TextStyle(fontSize: 20,letterSpacing: .9),),
                      ],
                    ),
                  ),
                  Expanded(child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xff130126),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(70))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * .05,),
                        const Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 30),),
                        const Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 17),),
                        SizedBox(height: size.height * .05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(40)),
                              ),
                              child: Row(
                                children: [
                                  const Text("+880",style: TextStyle(color: Colors.white,fontSize: 18),),
                                  const SizedBox(width: 9,),
                                  Image.asset("images/bd.png",height: 37,width: 37,)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * .6,
                              child: TextField(
                                controller: mobileNumber,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white,),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  hintStyle: const TextStyle(color: Colors.white),
                                  contentPadding: const EdgeInsets.all(18),
                                  fillColor: Colors.grey.shade700,
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
                                    borderSide: BorderSide(width: 0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
                                    borderSide: BorderSide(width: 0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * .03,),
                        InkWell(
                          onTap: ()async{
                            String demoNumber = '1860171089';
                            if(mobileNumber.text.toString().isNotEmpty){
                              if(mobileNumber.text.toString().length == 10 || mobileNumber.text.toString() == demoNumber){
                                loginPreferences.setPreferences("");
                                Get.offAndToNamed(RoutesName.channelSelectorScreen);
                              }
                            }else{
                              Get.snackbar(
                                  "",
                                  "",
                                snackPosition: SnackPosition.BOTTOM,
                                titleText: const Text("Please, input mobile number",style: TextStyle(color: Colors.white,fontSize: 16),),
                                messageText: const Text("You didn't input any mobile number",style: TextStyle(color: Colors.white,fontSize: 16),),
                                backgroundColor: Colors.white30
                              );
                            }
                          },
                          child: Container(
                            height: 60,
                            width: size.width *.8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: const Center(
                              child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * .06,),
                        const Text("Terms and Condition",style: TextStyle(color: Colors.white,fontSize: 15),),
                        SizedBox(height: size.height * .01,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text("Don't have an account?",style: TextStyle(color: Colors.white,fontSize: 15),),
                             SizedBox(width: 5,),
                             Text("Sign Up ",style: TextStyle(color: Colors.red,fontSize: 15),),
                          ]
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
