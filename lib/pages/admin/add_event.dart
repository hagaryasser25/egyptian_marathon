import 'dart:io';

import 'package:egyptian_marathon/pages/admin/admin_home.dart';
import 'package:egyptian_marathon/pages/rented/rented_home.dart';
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

class AddEvent extends StatefulWidget {
  static const routeName = '/addEvent';
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var codeController = TextEditingController();
  var dateController = TextEditingController();
  var placeController = TextEditingController();
  var appointmentController = TextEditingController();

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
                        hintText: 'كود المسابقة',
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
                        hintText: 'تاريخ المسابقة',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: placeController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#6bbcba'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'مكان التجمع',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: appointmentController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#6bbcba'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'موعد التجمع',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                        String place = placeController.text.trim();
                        String appointment = appointmentController.text.trim();

                        if (code.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل كود المسابقة');
                          return;
                        }

                        if (date.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل تاريخ المسابقة');
                          return;
                        }

                        if (place.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل مكان التجمع');
                          return;
                        }

                        if (appointment.isEmpty) {
                          Fluttertoast.showToast(msg: 'ادخل موعد التجمع');
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('events');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'date': date,
                            'place': place,
                            'appointment': appointment,
                            'code': code,
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
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة المسابقة"),
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
