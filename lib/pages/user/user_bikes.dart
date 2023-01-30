import 'package:egyptian_marathon/pages/models/bikes_model.dart';
import 'package:egyptian_marathon/pages/rented/add_bike.dart';
import 'package:egyptian_marathon/pages/user/book_bike.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserBike extends StatefulWidget {
  String type;
  static const routeName = '/rentedBike';
  UserBike({required this.type});

  @override
  State<UserBike> createState() => _UserBikeState();
}

class _UserBikeState extends State<UserBike> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Bikes> bikesList = [];
  List<String> keyslist = [];
  String dropdownValue = 'مصر الجديدة';

  @override
  void didChangeDependencies() {
    print(FirebaseAuth.instance.currentUser!.uid);
    super.didChangeDependencies();
    fetchBikes();
  }

  @override
  void fetchBikes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("bikes")
        .child('${widget.type}')
        .child('$dropdownValue');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Bikes p = Bikes.fromJson(event.snapshot.value);
      bikesList.add(p);
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
                title: Text('تأجير ${widget.type}')),
            body: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 20.h, left: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                        items: [
                          'مصر الجديدة',
                          'مدينة نصر',
                          'أكتوبر',
                          'التجمع',
                          'العبور',
                          'المعادى',
                          'المهندسين',
                          'الشروق',
                          'الشيخ زايد',
                          'مدينتى',
                          'بدر',
                          'شبرا',
                          'الحلمية',
                          'الزيتون'
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
                            dropdownValue = newValue!;
                            bikesList.clear();
                            fetchBikes();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 5000.h,
                      child: FutureBuilder(
                        builder: ((context, snapshot) {
                          return ListView.builder(
                              itemCount: bikesList.length,
                              itemBuilder: ((context, index) {
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
                                                        'سعر التأجير(ساعة) : ${bikesList[index].price}',
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
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            width: 90.w,
                                                            height: 40.h),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            HexColor('#6bbcba'),
                                                      ),
                                                      child: Text('حجز الأن'),
                                                      onPressed: () async {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return BookBike(
                                                            amount:
                                                                bikesList[index]
                                                                    .amount
                                                                    .toString(),
                                                            bikeCode:
                                                                bikesList[index]
                                                                    .code
                                                                    .toString(),
                                                            bikePrice:
                                                                bikesList[index]
                                                                    .price,
                                                            uid:
                                                                bikesList[index]
                                                                    .uid
                                                                    .toString(),
                                                          );
                                                        }));
                                                      },
                                                    ),
                                                  ),
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
                              }));
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
