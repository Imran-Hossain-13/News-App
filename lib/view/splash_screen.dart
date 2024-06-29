import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();


  @override
  void initState() {
    splashServices.isLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/splash_pic.jpg",
            fit: BoxFit.cover,
            height: size.height * .5,
          ),
          SizedBox(height: size.height * .04,),
          Text("DAILY NEWS",style: GoogleFonts.anton(textStyle: TextStyle(
            color: Colors.grey.shade700,
            letterSpacing: .6,
          )),),
          SizedBox(height: size.height * .04,),
          SpinKitChasingDots(
            color: Colors.red.shade100,
            size: 40,
          )
        ],
      )
    );
  }
}
