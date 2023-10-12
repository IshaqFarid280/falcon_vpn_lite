import 'package:eye_vpn_lite/screens/landing/home_screen.dart';
import 'package:eye_vpn_lite/screens/network/network_test_screen.dart';
import 'package:eye_vpn_lite/screens/policy/privacy_policy.dart';
import 'package:eye_vpn_lite/screens/share/share_with_friend_screen.dart';
import 'package:eye_vpn_lite/screens/speed_test/speed_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../helpers/ad_helper.dart';
import '../../helpers/config.dart';
import '../../helpers/pref.dart';
import '../../widgets/customer_support_alert_dialogue.dart';
import '../../widgets/rate_us_alert_dialog.dart';
import '../../widgets/watch_ad_dialog.dart';

class AnimatedDrawerScreen extends StatefulWidget {
  @override
  _AnimatedDrawerScreenState createState() => _AnimatedDrawerScreenState();
}

class _AnimatedDrawerScreenState extends State<AnimatedDrawerScreen> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pref.isDarkMode?Color(0xff022766):Color(0xffF6F4Ff),
      appBar: AppBar(
        backgroundColor: Pref.isDarkMode?Color(0xff0E2232):Color(0xff022766),
        elevation: 0,
        centerTitle: false,
        title: Text('ThorVPN-Fast & Secure Proxy', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            zoomDrawerController.toggle!();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                //ad dialog

                if (Config.hideAds) {
                  Get.changeThemeMode(
                      Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  Pref.isDarkMode = !Pref.isDarkMode;
                  return;
                }

                Get.dialog(WatchAdDialog(onComplete: () {
                  //watch ad to gain reward
                  AdHelper.showRewardedAd(onComplete: () {
                    setState(() {
                      Get.changeThemeMode(Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                      Pref.isDarkMode = !Pref.isDarkMode;
                    });
                  });
                }));
              },
              icon: Icon(Icons.brightness_medium, size: 26,),
          ),

        ],
      ),
      body: ZoomDrawer(
        controller: zoomDrawerController,
        menuScreen: MenuScreen(),
        mainScreen: HomeScreen(),
        borderRadius: 24.0,
        angle: -10.0,
        showShadow: true,
        drawerShadowsBackgroundColor: Color(0xff0E2232),
        slideWidth: MediaQuery.of(context).size.width * 0.75,
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pref.isDarkMode?Color(0xff022766):Color(0xffF6F4Ff),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.home,color: Colors.white,)),
            title: Text('Home',style: TextStyle(color: Pref.isDarkMode?Colors.green:Colors.orange,fontSize: 16.sp),),
            onTap: () {

              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.speed,color: Colors.white,)),
            title: Text('Speed Test',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),),
            onTap: () {
              Get.to(()=>SpeedTestScreen(),transition: Transition.rightToLeft);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.network_cell,color: Colors.white,)),
            title: Text('Network Info',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),),
            onTap: () {
              Get.to(()=>NetworkTestScreen(),transition: Transition.rightToLeft);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.people_outline,color: Colors.white,)),
            title: Text('Invite Friends',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),),
            onTap: () {
              Get.to(()=>ShareWithFriendsScreen(),transition: Transition.rightToLeft);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.support,color: Colors.white,)),
            title: Text('Customer Support',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),),
            onTap: () {
              customerSupportAlertDialogue(context);

              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.star,color: Colors.white,)),
            title: Text('Rate us',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),),
            onTap: () {
              RateUsAlertDialog(context);
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.privacy_tip,color: Colors.white,)),
            title: Text('Privacy Policy',style: TextStyle(color: Pref.isDarkMode?Colors.white:Colors.black,fontSize: 16.sp),),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
              showBottomSheet(
                context: context,
                builder: (context) {
                  return const PrivacyPolicy();
                },
              );
            },
          ),

        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Main Content Goes Here',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
