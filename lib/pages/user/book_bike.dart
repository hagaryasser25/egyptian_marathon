import 'dart:io';

import 'package:egyptian_marathon/pages/admin/admin_home.dart';
import 'package:egyptian_marathon/pages/rented/rented_home.dart';
import 'package:egyptian_marathon/pages/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class BookBike extends StatefulWidget {
  String bikeCode;
  String uid;
  var bikePrice;
  String amount;
  static const routeName = '/bookBike';
  BookBike(
      {required this.bikeCode,
      required this.uid,
      required this.bikePrice,
      required this.amount});

  @override
  State<BookBike> createState() => _BookBikeState();
}

class _BookBikeState extends State<BookBike> {
  var codeController = TextEditingController();
  var dateController = TextEditingController();
  var hoursController = TextEditingController();
  late String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserEmail();
  }

  void getUserEmail() {
    email = FirebaseAuth.instance.currentUser!.email!;
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#6bbcba'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الرقم القومى',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: hoursController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#6bbcba'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'عدد ساعات التأجير',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#6bbcba'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'موعد التأجير',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#6bbcba'),
                      ),
                      onPressed: () async {
                        String code = codeController.text.trim();
                        String date = dateController.text.trim();
                        int hours = int.parse(hoursController.text);
                        int profit = (widget.bikePrice) * hours;
                        double rentedProfit = profit * (0.8);
                        double adminProfit = profit * (0.2);

                        if (code.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل الرقم القومى');
                          return;
                        }


                        if (date.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل تاريخ التأجير');
                          return;
                        }

                        if (hours == null) {
                          Fluttertoast.showToast(msg: 'ادخل عدد ساعات التأجير');
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('bikesBookings');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'date': date,
                            'code': code,
                            'hours': hours,
                            'bikeCode': widget.bikeCode,
                            'amount': widget.amount,
                            'bikeUid': widget.uid,
                            'rentedProfit': rentedProfit,
                            'adminProfit': adminProfit,
                            'profit': profit,
                            'userEmail': email,
                            'id': id,
                          });
                        }

                        showAlertDialog(context);
                      },
                      child: Text('حفظ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم الحجز'),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
