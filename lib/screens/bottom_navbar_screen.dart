import 'package:eye_vpn_lite/screens/home_screen.dart';
import 'package:eye_vpn_lite/screens/network_test_screen.dart';
import 'package:eye_vpn_lite/screens/speed_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/ad_helper.dart';
import '../helpers/config.dart';
import '../helpers/pref.dart';
import '../widgets/watch_ad_dialog.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('EYE VPN Lite'),
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
                    Get.changeThemeMode(
                        Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    Pref.isDarkMode = !Pref.isDarkMode;
                  });
                }));
              },
              icon: Icon(
                Icons.brightness_medium,
                size: 26,
              )),
        ],
      ),
      body: ZoomDrawer(
        controller: zoomDrawerController,
        menuScreen: MenuScreen(),
        mainScreen: HomeScreen(),
        borderRadius: 24.0,
        angle: -10.0,
        showShadow: true,

        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.home,color: Colors.white,),
            title: Text('Home',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {

              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.speed,color: Colors.white,),
            title: Text('Speed Test',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SpeedTestScreen()));
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline,color: Colors.white,),
            title: Text('Network Info',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.share,color: Colors.white,),
            title: Text('Share',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.support,color: Colors.white,),
            title: Text('Customer Support',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.star,color: Colors.white,),
            title: Text('Rate us',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.info,color: Colors.white,),
            title: Text('About us',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip,color: Colors.white,),
            title: Text('Privacy Policy',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkTestScreen()));
              // Handle network info navigation
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
