import 'package:egyptian_marathon/pages/admin/admin_events.dart';
import 'package:egyptian_marathon/pages/admin/bike_list.dart';
import 'package:egyptian_marathon/pages/admin/event_list.dart';
import 'package:egyptian_marathon/pages/rented/rented_bike.dart';
import 'package:egyptian_marathon/pages/user/events_sub.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../landing_page.dart';

class UserTypes extends StatefulWidget {
  static const routeName = '/userTypes';
  const UserTypes({super.key});

  @override
  State<UserTypes> createState() => _UserTypesState();
}

class _UserTypesState extends State<UserTypes> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: HexColor('#6bbcba'),
              title: Align(
                  alignment: Alignment.center, child: Text('انواع المسابقات'))),
          body: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h, right: 15.w, left: 25.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EventsSub(
                                    type: 'دراجات هوائية',
                                  );
                                }));
                              },
                              child: card(
                                  'assets/images/bike2.png', 'دراجات هوائية')),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EventsSub(
                                    type: 'دراجات نارية',
                                  );
                                }));
                              },
                              child: card(
                                  'assets/images/motor.png', 'دراجات نارية')),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EventsSub(
                                    type: "سيارات",
                                  );
                                }));
                              },
                              child: card('assets/images/car.png', 'سيارات')),
                          InkWell(
                              onTap: () {
                                
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EventsSub(
                                    type: 'خيل',
                                  );
                                }));
                              },
                              child: card('assets/images/horse.jpg', 'خيل')),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      InkWell(
                          onTap: () {
                            
                            Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EventsSub(
                                    type: "سباحة",
                                  );
                                }));
                          },
                          child: card('assets/images/images.png', 'سباحة')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(String url, String text) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 150.w,
        height: 150.h,
        child: Column(children: [
          SizedBox(
            height: 2.h,
          ),
          Container(width: 130.w, height: 100.h, child: Image.asset(url)),
          SizedBox(height: 5),
          Text(text, style: TextStyle(fontSize: 18, color: HexColor('#32486d')))
        ]),
      ),
    ),
  );
}
