import 'package:egyptian_marathon/pages/admin/add_event.dart';
import 'package:egyptian_marathon/pages/models/events_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class AdminEvent extends StatefulWidget {
  static const routeName = '/adminEvent';
  const AdminEvent({super.key});

  @override
  State<AdminEvent> createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Events> eventsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCourses();
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
            title: Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  // Your icon here
                  label: Text(
                    'أضافة مسابقة',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Align(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )), // Your text here
                  onPressed: () {
                    Navigator.pushNamed(context, AddEvent.routeName);
                  },
                )),
          ),
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
                    Text(
                        '${eventsList[index].date.toString()}'),
                    SizedBox(height: 5.h),
                    Text('${eventsList[index].place.toString()}'),
                    SizedBox(height: 5.h),
                    Text(
                        '${eventsList[index].appointment.toString()}'),
                    SizedBox(height: 5.h),
                    InkWell(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));
                        base.child(eventsList[index].id.toString()).remove();
                      },
                      child: Icon(Icons.delete,
                          color: Color.fromARGB(255, 122, 122, 122)),
                    )
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
