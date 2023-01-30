import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/SignUp';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  String dropdownValue = 'مؤجر';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
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
                    controller: fullNameController,
                    decoration: InputDecoration(
                      fillColor: HexColor('#155564'),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor('#155564'), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'اسم المستخدم',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 65.h,
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor('#155564'), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'رقم الهاتف',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 65.h,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor('#155564'), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'البريد الألكترونى',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 65.h,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor('#155564'), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'كلمة المرور',
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
                    value: dropdownValue,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 119, 118, 118)),
                    ),

                    // Step 4.
                    items: ['مؤجر', 'مستأجر']
                        .map<DropdownMenuItem<String>>((String value) {
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
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: double.infinity, height: 65.h),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#6bbcba'),
                      ),
                      child: Text('انشاء حساب'),
                      onPressed: () async {
                        var fullName = fullNameController.text.trim();
                        var phoneNumber = phoneNumberController.text.trim();
                        var email = emailController.text.trim();
                        var password = passwordController.text.trim();
                        String role = dropdownValue;

                        if (fullName.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            phoneNumber.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please fill all fields');
                          return;
                        }
                        if (password.length < 6) {
                          // show error toast
                          Fluttertoast.showToast(
                              msg:
                                  'Weak Password, at least 6 characters are required');

                          return;
                        }

                        ProgressDialog progressDialog = ProgressDialog(context,
                            title: Text('Signing Up'),
                            message: Text('Please Wait'));
                        progressDialog.show();

                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          UserCredential userCredential =
                              await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          User? user = userCredential.user;
                          user!.updateProfile(displayName: role);

                          if (userCredential.user != null) {
                            DatabaseReference userRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('users');

                            String uid = userCredential.user!.uid;
                            int dt = DateTime.now().millisecondsSinceEpoch;

                            await userRef.child(uid).set({
                              'fullName': fullName,
                              'email': email,
                              'uid': uid,
                              'dt': dt,
                              'phoneNumber': phoneNumber,
                              'role': role,
                            });

                            Fluttertoast.showToast(msg: 'Success');

                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(msg: 'Failed');
                          }
                          progressDialog.dismiss();
                        } on FirebaseAuthException catch (e) {
                          progressDialog.dismiss();
                          if (e.code == 'email-already-in-use') {
                            Fluttertoast.showToast(
                                msg: 'Email is already exist');
                          } else if (e.code == 'weak-password') {
                            Fluttertoast.showToast(msg: 'Password is weak');
                          }
                        } catch (e) {
                          progressDialog.dismiss();
                          Fluttertoast.showToast(msg: 'Something went wrong');
                        }
                      
                        
                      },
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
