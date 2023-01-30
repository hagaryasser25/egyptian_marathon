import 'package:egyptian_marathon/pages/admin/add_event.dart';
import 'package:egyptian_marathon/pages/admin/admin_events.dart';
import 'package:egyptian_marathon/pages/admin/bike_list.dart';
import 'package:egyptian_marathon/pages/admin/booking_list.dart';
import 'package:egyptian_marathon/pages/admin/event_list.dart';
import 'package:egyptian_marathon/pages/auth/admin_login.dart';
import 'package:egyptian_marathon/pages/auth/login.dart';
import 'package:egyptian_marathon/pages/auth/rented_login.dart';
import 'package:egyptian_marathon/pages/auth/signup.dart';
import 'package:egyptian_marathon/pages/landing_page.dart';
import 'package:egyptian_marathon/pages/rented/add_bike.dart';
import 'package:egyptian_marathon/pages/rented/join_event.dart';
import 'package:egyptian_marathon/pages/rented/rented_bike.dart';
import 'package:egyptian_marathon/pages/rented/rented_home.dart';
import 'package:egyptian_marathon/pages/rented/rented_list.dart';
import 'package:egyptian_marathon/pages/user/user_home.dart';
import 'package:egyptian_marathon/pages/user/user_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/admin/admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LandingPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == 'مؤجر'
                  ? const RentedHome()
                  : UserHome(),
      routes: {
        SignUp.routeName: (ctx) => SignUp(),
        LoginPage.routeName: (ctx) => LoginPage(),
        UserHome.routeName: (ctx) => UserHome(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        RentedLogin.routeName: (ctx) => RentedLogin(),
        RentedHome.routeName: (ctx) => RentedHome(),
        AddBike.routeName: (ctx) => AddBike(),
        LandingPage.routeName: (ctx) => LandingPage(),
        AdminEvent.routeName: (ctx) => AdminEvent(),
        AddEvent.routeName: (ctx) => AddEvent(),
        JoinEvent.routeName: (ctx) => JoinEvent(),
        EventList.routeName: (ctx) => EventList(),
        BookingList.routeName: (ctx) => BookingList(),
        BikeList.routeName: (ctx) => BikeList(),
        RentedList.routeName: (ctx) => RentedList(),
        UserList.routeName: (ctx) => UserList(),
      },
    );
  }
}
