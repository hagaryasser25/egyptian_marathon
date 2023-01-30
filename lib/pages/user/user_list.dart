import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../models/bikesList_model.dart';
import '../models/eventsList_model.dart';

class UserList extends StatefulWidget {
  static const routeName = '/userList';
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<BikeBookings> bikeList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBikes();
  }

  @override
  void fetchBikes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bikesBookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      BikeBookings p = BikeBookings.fromJson(event.snapshot.value);
      bikeList.add(p);
      print(bikeList.length);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: HexColor('#6bbcba'), title: Text('تأجيراتك')),
            body: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: FutureBuilder(
                builder: ((context, snapshot) {
                  return ListView.builder(
                      itemCount: bikeList.length,
                      itemBuilder: ((context, index) {
                        var date = bikeList[index].date;
                        if (FirebaseAuth.instance.currentUser!.email ==
                            bikeList[index].userEmail) {
                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 15,
                                        left: 15,
                                        bottom: 10),
                                    child: Column(children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'كود الدراجة : ${bikeList[index].bikeCode.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'تاريخ التأجير : ${bikeList[index].date.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'عدد ساعات التأجير : ${bikeList[index].hours.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'اجمالى السعر : ${bikeList[index].profit.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'مبلغ التأمين : ${bikeList[index].amount.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget));
                                          base
                                              .child(bikeList[index]
                                                  .id
                                                  .toString())
                                              .remove();
                                        },
                                        child: Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 122, 122, 122)),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              )
                            ],
                          );
                        } else {
                          return Text('');
                        }
                      }));
                }),
              ),
            )),
      ),
    );
  }

  String getDate(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);

    return DateFormat('MMM dd yyyy').format(dateTime);
  }
}
