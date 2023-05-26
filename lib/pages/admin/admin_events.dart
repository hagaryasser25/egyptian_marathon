import 'package:egyptian_marathon/pages/admin/add_event.dart';
import 'package:egyptian_marathon/pages/admin/edit_event.dart';
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
          body: ListView.builder(
            itemCount: eventsList.length,
            itemBuilder: (BuildContext context, int index) {
              var date = eventsList[index].date;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 15, bottom: 10),
                          child: Column(children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'اسم المسابقة : ${eventsList[index].name.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'نوع المسابقة : ${eventsList[index].type.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'اسم الراعى: ${eventsList[index].organizer.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'رسوم الاشتراك: ${eventsList[index].price.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'التاريخ: ${eventsList[index].date.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'الوقت: ${eventsList[index].time.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'مكان التجمع: ${eventsList[index].place.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'موعد التجمع: ${eventsList[index].appointment.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'شروط المسابقة: ${eventsList[index].conditions.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120.w,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                    base
                                        .child(eventsList[index].id.toString())
                                        .remove();
                                  },
                                  child: Icon(Icons.delete,
                                      color:
                                          Color.fromARGB(255, 122, 122, 122)),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                InkWell(
                                  onTap: () async {
                                    
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return EditEvent(
                                        name: eventsList[index].name.toString(),
                                        type: eventsList[index].type.toString(),
                                        date: eventsList[index].date.toString(),
                                        organizer: eventsList[index].organizer.toString(),
                                        price: eventsList[index].price.toString(),
                                        time: eventsList[index].time.toString(),
                                        place: eventsList[index].place.toString(),
                                        appointment: eventsList[index].appointment.toString(),
                                        condition: eventsList[index].conditions.toString(),
                                        id: eventsList[index].id.toString(),

                                      );
                                    }));
                                    
                                  },
                                  child: Icon(Icons.edit,
                                      color:
                                          Color.fromARGB(255, 122, 122, 122)),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
