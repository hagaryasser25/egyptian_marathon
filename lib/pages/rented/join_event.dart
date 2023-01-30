import 'package:egyptian_marathon/pages/admin/add_event.dart';
import 'package:egyptian_marathon/pages/models/events_model.dart';
import 'package:egyptian_marathon/pages/rented/rented_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class JoinEvent extends StatefulWidget {
  static const routeName = '/joinEvent';
  const JoinEvent({super.key});

  @override
  State<JoinEvent> createState() => _JoinEventState();
}

class _JoinEventState extends State<JoinEvent> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Events> eventsList = [];
  List<String> keyslist = [];
  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCourses();
    getUserEmail();
  }

  void getUserEmail() {
    email = FirebaseAuth.instance.currentUser!.email!;
    print(email);
  }

  @override
  void fetchCourses() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("events");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Events p = Events.fromJson(event.snapshot.value);
      eventsList.add(p);
      print(eventsList.length);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: HexColor('#6bbcba'),
              title: Text('الأشتراك فى مسابقة')),
          body: Container(
            decoration: BoxDecoration(color: HexColor('#eaf2f8')),
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 15.w,
                right: 15.w,
                bottom: 15.h,
              ),
              crossAxisCount: 6,
              itemCount: eventsList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(children: [
                    SizedBox(height: 25.h),
                    Text(
                      '${eventsList[index].code.toString()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5.h),
                    Text('${eventsList[index].date.toString()}'),
                    SizedBox(height: 5.h),
                    Text('${eventsList[index].place.toString()}'),
                    SizedBox(height: 5.h),
                    Text('${eventsList[index].appointment.toString()}'),
                    SizedBox(height: 5.h),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 80.w, height: 35.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#6bbcba'),
                        ),
                        child: Text('اشتراك'),
                        onPressed: () async {
                                User? user = FirebaseAuth.instance.currentUser;

                                if (user != null) {
                                  String uid = user.uid;
                                  int date =
                                      DateTime.now().millisecondsSinceEpoch;

                                  DatabaseReference companyRef =
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child('eventsBookings');

                                  String? id = companyRef.push().key;

                                  await companyRef.child(id!).set({
                                    'date': date,
                                    'userEmail': email,
                                    'code': eventsList[index].code.toString(),
                                  });
                                }
                                showAlertDialog(context);
                                
                        },
                      ),
                    ),
                  ]),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(3, index.isEven ? 3 : 3),
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 5.0,
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
      Navigator.pushNamed(context, RentedHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم الأشتراك بنجاح'),
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