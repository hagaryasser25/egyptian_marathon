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

class AddEvent extends StatefulWidget {
  static const routeName = '/addEvent';
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var nameController = TextEditingController();
  var organizerController = TextEditingController();
  String dropdownValue2 = 'دراجات هوائية';
  var dateController = TextEditingController();
  var priceController = TextEditingController();
  var timeController = TextEditingController();
  var placeController = TextEditingController();
  var appointmentController = TextEditingController();
  var conditionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 183, 183, 183),
                              width: 2.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),

                        // Step 3.
                        value: dropdownValue2,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 119, 118, 118)),
                        ),

                        // Step 4.
                        items: [
                          'دراجات هوائية',
                          'دراجات نارية',
                          'خيل',
                          'سيارات',
                          'سباحة'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 119, 118, 118)),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      controller: dateController,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "تاريخ المسابقة" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                    SizedBox(height: 20.h),
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
                          hintText: 'اسم المسابقة',
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
                          hintText: 'اسم الراعى',
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
                          hintText: 'وقت المسابقة',
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
                          hintText: 'مكان التجمع',
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
                        controller: conditionsController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: HexColor('#6bbcba'), width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'شروط المسابقة',
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
                          hintText: 'رسوم الحضور',
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
                          String conditions = conditionsController.text.trim();
                          String type = dropdownValue2;

                          if (name.isEmpty ||
                              organizer.isEmpty ||
                              date.isEmpty ||
                              time.isEmpty ||
                              price.isEmpty ||
                              place.isEmpty ||
                              appointment.isEmpty ||
                              conditions.isEmpty) {
                            CherryToast.info(
                              title: Text('ادخل جميع الحقول'),
                              actionHandler: () {},
                            ).show(context);
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
                              'name': name,
                              'organizer': organizer,
                              'time': time,
                              'price': price,
                              'date': date,
                              'place': place,
                              'appointment': appointment,
                              'conditions': conditions,
                              'type': type,
                              'id': id,
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
