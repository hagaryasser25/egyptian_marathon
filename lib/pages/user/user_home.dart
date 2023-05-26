import 'package:egyptian_marathon/pages/rented/rented_bike.dart';
import 'package:egyptian_marathon/pages/user/user_bikes.dart';
import 'package:egyptian_marathon/pages/user/user_event.dart';
import 'package:egyptian_marathon/pages/user/user_list.dart';
import 'package:egyptian_marathon/pages/user/user_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../landing_page.dart';
import '../models/users_model.dart';
import '../rented/join_event.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

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
                  alignment: Alignment.center, child: Text('الصفحة الرئيسية'))),
          drawer: Drawer(
            child: FutureBuilder(
              future: getUserData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (currentUser == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: HexColor('#6bbcba'),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.amber.shade500,
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("معلومات المستخدم",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  Navigator.popAndPushNamed(
                                      context, UserList.routeName);
                                },
                                title: Text('تأجيراتك'),
                                leading: Icon(Icons.list_alt),
                              ))),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  Navigator.popAndPushNamed(
                                      context, UserTypes.routeName);
                                },
                                title: Text('اشتراكاتك'),
                                leading: Icon(Icons.list_alt),
                              ))),
                      Divider(
                        thickness: 0.8,
                        color: Colors.grey,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                        ),
                        title: const Text('اسم المستخدم'),
                        subtitle: Text('${currentUser.fullName}'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                        ),
                        title: const Text('البريد الالكترونى'),
                        subtitle: Text('${currentUser.email}'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                        ),
                        title: const Text('رقم الهاتف'),
                        subtitle: Text('${currentUser.phoneNumber}'),
                      ),
                      Divider(
                        thickness: 0.8,
                        color: Colors.grey,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('تأكيد'),
                                          content: Text(
                                              'هل انت متأكد من تسجيل الخروج'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushNamed(context,
                                                    LandingPage.routeName);
                                              },
                                              child: Text('نعم'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('لا'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                title: Text('تسجيل الخروج'),
                                leading: Icon(Icons.exit_to_app_rounded),
                              )))
                    ],
                  );
                }
              },
            ),
          ),
          body: Column(
            children: [
              Image.asset('assets/images/rented.jpg'),
              SizedBox(height: 20.h),
              Text(
                'الخدمات المتاحة',
                style: TextStyle(fontSize: 27, color: HexColor('#155564')),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 19.w, left: 19.w),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserBike(
                              type: 'دراجة هوائية',
                            );
                          }));
                        },
                        child: card(
                            'assets/images/bike2.png', "تأجير دراجة هوائية")),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserBike(
                              type: 'دراجة نارية',
                            );
                          }));
                        },
                        child: card(
                            'assets/images/motor.png', "تأجير دراجة نارية")),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, LandingPage.routeName);
                        },
                        child: card('assets/images/exit3.png', "تسجيل الخروج")),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, UserEvent.routeName);
                        },
                        child: card(
                            'assets/images/event.jpg', 'الأشتراك فى مسابقة')),
                  ],
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
