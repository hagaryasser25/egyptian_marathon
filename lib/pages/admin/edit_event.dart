import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
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
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class EditEvent extends StatefulWidget {
  String name;
  String organizer;
  String date;
  String price;
  String time;
  String place;
  String appointment;
  String condition;
  String id;
  String type;
  static const routeName = '/editEvent';
  EditEvent({
    required this.name,
    required this.organizer,
    required this.date,
    required this.price,
    required this.time,
    required this.place,
    required this.appointment,
    required this.condition,
    required this.id,
    required this.type,
  });

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  var nameController = TextEditingController();
  var typeController = TextEditingController();
  var organizerController = TextEditingController();
  var dateController = TextEditingController();
  var priceController = TextEditingController();
  var timeController = TextEditingController();
  var placeController = TextEditingController();
  var appointmentController = TextEditingController();
  var conditionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;
    typeController.text = widget.type;
    organizerController.text = widget.organizer;
    dateController.text = widget.date;
    priceController.text = widget.price;
    timeController.text = widget.time;
    placeController.text = widget.place;
    appointmentController.text = widget.appointment;
    conditionController.text = widget.condition;
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: SingleChildScrollView(
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
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'اسم المسابقة',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: typeController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'نوع المسابقة',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: organizerController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'اسم الراعى',
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
                          labelText: 'تاريخ المسابقة',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'وقت المسابقة',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 150.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                        controller: placeController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'مكان التجمع',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 150.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                        controller: conditionController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                         labelText: 'شروط المسابقة',
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
                          labelText: 'موعد التجمع',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'رسوم الحضور',
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
                          String name = nameController.text.trim();
                          String organizer = organizerController.text.trim();
                          String date = dateController.text.trim();
                          String price = priceController.text.trim();
                          String time = timeController.text.trim();
                          String place = placeController.text.trim();
                          String appointment =
                              appointmentController.text.trim();
                          String conditions = conditionController.text.trim();
                          String type = typeController.text.trim();

                          User? user = await FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            DatabaseReference userRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('events')
                                .child('${widget.id}');

                            await userRef.update({
                              'name': name,
                              'organizer': organizer,
                              'date': date,
                              'price': price,
                              'time': time,
                              'place': place,
                              'appointment': appointment,
                              'conditions': conditions,
                              'type': type,
                              
                            });
                          }

                          showAlertDialog(context);
                        },
                        child: Text('حفظ'),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
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
    content: Text("تم حفظ التعديل"),
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
