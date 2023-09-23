import 'package:eye_vpn_lite/screens/bottom_navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

import '../helpers/ad_helper.dart';
import '../main.dart';
import 'home_screen.dart';
import 'onbgoarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      //exit full-screen
      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();

      //navigate to home
     Get.off(() => OnBoard());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => OnBoard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff02273e), Colors.blue], // Gradient colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(
                child: Image.asset("assets/images/eye_no_bg.png",height: 150.h,width: 150.w,),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("EYE VPN Lite",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    fontSize: 18.sp
                  ),)
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 60.w, vertical: 100.h),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue,),
                    ),
                  ],
                ),
              ),

              // IconButton(onPressed: (){
              //   splashScreenController.authorizeWithBiometricsOrPassword();
              // }, icon: Icon(Icons.fingerprint,size: 65.h,color: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }
}
