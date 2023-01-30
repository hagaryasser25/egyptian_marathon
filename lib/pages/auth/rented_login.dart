import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

import '../admin/admin_home.dart';
import '../rented/rented_home.dart';
import '../user/user_home.dart';

class RentedLogin extends StatefulWidget {
  static const routeName = '/rentedLogin';
  const RentedLogin({super.key});

  @override
  State<RentedLogin> createState() => _RentedLoginState();
}

class _RentedLoginState extends State<RentedLogin> {
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
                            Navigator.pushNamed(context, RentedHome.routeName);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}