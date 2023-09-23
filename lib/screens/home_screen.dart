import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../helpers/ad_helper.dart';
import '../helpers/config.dart';
import '../helpers/pref.dart';
import '../main.dart';

import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import '../widgets/watch_ad_dialog.dart';
import 'location_screen.dart';
import 'network_test_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      //body
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, children: [
          //vpn button
          Container(
            color: Color(0xff02273e),
            height: 500,
            width: double.infinity,
            child:    Obx(() => Column(
              children: [
                _vpnButton(),
              ],
            )),
          ),

          _changeLocation(context),
          
          Card(
            elevation: 0,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10
                ),
                child:
                    Obx(() =>  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200
                              ),
                              height: 50,
                              width: 80,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                child: _controller.vpn.value.countryLong.isEmpty
                                    ? Icon(Icons.vpn_lock_rounded,
                                    size: 30, color: Colors.white)
                                    : null,
                                backgroundImage: _controller.vpn.value.countryLong.isEmpty
                                    ? null
                                    : AssetImage(
                                    'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                              ),
                            ),
                            SizedBox(width: 10,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_controller.vpn.value.countryLong.isEmpty
                                    ? 'Country'
                                    : _controller.vpn.value.countryLong,style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("FREE",style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54
                                  ),),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //ping time
                        Expanded(
                          child: HomeCard(
                              color: Colors.black45,
                              title: _controller.vpn.value.countryLong.isEmpty
                                  ? '100 ms'
                                  : '${_controller.vpn.value.ping} ms',
                              icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.orange,
                                child: Icon(Icons.equalizer_rounded,
                                    size: 18, color: Colors.white),
                              )),
                        ),

                      ],
                    ), ),

              ),
            ),
          )

        ]),
      ),
    );
  }

  //vpn button
  Widget _vpnButton() => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 20
    ),
    child: Column(
          children: [

            Text("Connecting Time",style: TextStyle(color: Colors.white70),),

            SizedBox(height: 5,),

            //count down timer
            Obx(() => CountDownTimer(
                startTimer:
                _controller.vpnState.value == VpnEngine.vpnConnected)),

            SizedBox(height: 15,),

            //button
            Semantics(
              button: true,
              child: InkWell(
                onTap: () {
                  _controller.connectToVpn();
                },
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.1)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor.withOpacity(.3)),
                    child: Container(
                      width: mq.height * .14,
                      height: mq.height * .14,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controller.getButtonColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //icon
                          Icon(
                            Icons.power_settings_new,
                            size: 28,
                            color: Colors.white,
                          ),

                          SizedBox(height: 4),

                          //text
                          Text(
                            _controller.getButtonText,
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10,),
            //connection status label
            Container(
              margin:
                  EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              child: Text(
                _controller.vpnState.value == VpnEngine.vpnDisconnected
                    ? 'Not Connected'
                    : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
                style: TextStyle(fontSize: 12.5, color: Colors.white,fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 25,),
            StreamBuilder<VpnStatus?>(
                initialData: VpnStatus(),
                stream: VpnEngine.vpnStatusSnapshot(),
                builder: (context, snapshot) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //download
                      HomeCard(
                          title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                          subtitle: 'DOWNLOAD',
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.lightGreen,
                            child: Icon(Icons.arrow_downward_rounded,
                                size: 20, color: Colors.white),
                          )),


                      //upload
                      HomeCard(
                          title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                          subtitle: 'UPLOAD',
                          icon: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.arrow_upward_rounded,
                                size: 20, color: Colors.white),
                          )),
                    ],
                  ),
                )),
          ],
        ),
  );

  //bottom nav to change location
  Widget _changeLocation(BuildContext context) => Semantics(
        button: true,
        child: InkWell(
  onTap: () => Get.to(() => LocationScreen()),
  child: Container(
      color: Theme.of(context).bottomNav,
      padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
      height: 60,
      child: Row(
        children: [
          //icon
          Icon(CupertinoIcons.globe, color: Colors.white, size: 28),

          //for adding some space
          SizedBox(width: 10),

          //text
          Text(
            'Change Location',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),

          //for covering available spacing
          Spacer(),

          //icon
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.keyboard_arrow_right_rounded,
                color: Colors.blue, size: 26),
          )
        ],
      )),
        ),
      );
}
