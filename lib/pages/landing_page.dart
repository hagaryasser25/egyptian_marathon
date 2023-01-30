import 'package:egyptian_marathon/pages/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'auth/login.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landingPage';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Scaffold(
        body: Column(
          children: [
            Image.asset('assets/images/landing2.jpg'),
            SizedBox(height: 40.h),
            Text(
              'Egyptian Marathon',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lobster',
                  color: HexColor('#155564')),
            ),
            SizedBox(height: 100.h),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 230.w, height: 50.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#6bbcba'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // <-- Radius
                  ),
                ),
                child: Text('تسجيل الدخول'),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
              ),
            ),
            SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 230.w, height: 50.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#6bbcba'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // <-- Radius
                  ),
                ),
                child: Text('انشاء حساب'),
                onPressed: () {
                  Navigator.pushNamed(context, SignUp.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
