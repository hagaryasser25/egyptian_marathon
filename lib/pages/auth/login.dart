import 'package:egyptian_marathon/pages/admin/admin_home.dart';
import 'package:egyptian_marathon/pages/auth/admin_login.dart';
import 'package:egyptian_marathon/pages/auth/rented_login.dart';
import 'package:egyptian_marathon/pages/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

import '../user/user_home.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
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
                    controller: emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor('#6bbcba'), width: 2.0),
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
                            BorderSide(color: HexColor('#6bbcba'), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'كلمة المرور',
                    ),
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
                    child: Text('تسجيل الدخول'),
                    onPressed: () async{
                      var email = emailController.text.trim();
                      var password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please fill all fields');
                        return;
                      }
                      ProgressDialog progressDialog = ProgressDialog(context,
                          title: Text('Logging In'),
                          message: Text('Please Wait'));
                      progressDialog.show();

                      try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          UserCredential userCredential =
                              await auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                
                          if (userCredential.user != null) {
                            progressDialog.dismiss();
                            Navigator.pushNamed(context, UserHome.routeName);
                          }
                        } on FirebaseAuthException catch (e) {
                          progressDialog.dismiss();
                          if (e.code == 'user-not-found') {
                            Fluttertoast.showToast(msg: 'User not found');
                          } else if (e.code == 'wrong-password') {
                            Fluttertoast.showToast(msg: 'Wrong password');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(msg: 'Something went wrong');
                          progressDialog.dismiss();
                        }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 45.w, top: 20.h),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AdminLogin.routeName);
                          },
                          child: Text(
                            'تسجيل الدخول كأدمن',
                            style: TextStyle(color: HexColor('#6bbcba')),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RentedLogin.routeName);
                          },
                          child: Text(
                            'تسجيل الدخول كمؤجر',
                            style: TextStyle(color: HexColor('#6bbcba')),
                          )),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUp.routeName);
                    },
                    child: Text(
                      'اضغط هنا لأنشاء حساب',
                      style: TextStyle(color: HexColor('#6bbcba')),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
