import 'package:egyptian_marathon/pages/models/bikes_model.dart';
import 'package:egyptian_marathon/pages/rented/add_bike.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class RentedBike extends StatefulWidget {
  String type;
  static const routeName = '/rentedBike';
  RentedBike({required this.type});

  @override
  State<RentedBike> createState() => _RentedBikeState();
}

class _RentedBikeState extends State<RentedBike> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Bikes> bikesList = [];
  List<Bikes> searchList = [];
  List<String> keyslist = [];
  String dropdownValue = 'مصر الجديدة';

  @override
  void didChangeDependencies() {
    print(FirebaseAuth.instance.currentUser!.uid);
    super.didChangeDependencies();
    fetchDoctors();
  }


  void fetchDoctors() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bikes").child('${widget.type}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Bikes p = Bikes.fromJson(event.snapshot.value);
      bikesList.add(p);
      searchList.add(p);
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
                      'أضافة دراجة',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    icon: Align(
                        child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )), // Your text here
                    onPressed: () {
                      Navigator.pushNamed(context, AddBike.routeName);
                    },
                  )),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 20.h, left: 20.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 70.h,
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ابحث بالمنطقة',
                        
                      ),
                      onChanged: (char) {
                      setState(() {
                        if (char.isEmpty) {
                          setState(() {
                            bikesList = searchList;
                          });
                        } else {
                          bikesList = [];
                          for (Bikes model in searchList) {
                            if (model.area!.contains(char)) {
                              bikesList.add(model);
                            }
                          }
                          setState(() {});
                        }
                      });
                    },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    flex: 8,
                    child: FutureBuilder(
                      builder: ((context, snapshot) {
                        return ListView.builder(
                            itemCount: bikesList.length,
                            itemBuilder: ((context, index) {
                              if (FirebaseAuth.instance.currentUser!.uid ==
                                  bikesList[index].uid) {
                                return Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              right: 15,
                                              left: 15,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 110.w,
                                                height: 170.h,
                                                child: Image.network(
                                                    '${bikesList[index].imageUrl.toString()}'),
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.w),
                                                    child: Text(
                                                        'سعر التأجير(ساعة) : ${bikesList[index].price.toString()}',
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.w),
                                                    child: Text(
                                                        'مبلغ التأمين : ${bikesList[index].amount.toString()}',
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.w),
                                                    child: Text(
                                                        'اسم المؤجر : ${bikesList[index].rentedName.toString()}',
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.w),
                                                    child: Text(
                                                        'رقم الهاتف : ${bikesList[index].rentedPhone.toString()}',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  super
                                                                      .widget));
                                                      base
                                                          .child(
                                                              bikesList[index]
                                                                  .id
                                                                  .toString())
                                                          .remove();
                                                    },
                                                    child: Icon(Icons.delete,
                                                        color: Color.fromARGB(
                                                            255,
                                                            122,
                                                            122,
                                                            122)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h)
                                  ],
                                );
                              } else {
                                return Text('');
                              }
                            }));
                      }),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
