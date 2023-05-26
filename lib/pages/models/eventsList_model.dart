import 'package:flutter/cupertino.dart';

class EventBookings {
  EventBookings({
    String? eventname,
    String? userEmail,
    int? date,

  }) {
    _eventname = eventname;
    _userEmail = userEmail;
    _date = date;
  }

  EventBookings.fromJson(dynamic json) {
    _eventname = json['name'];
    _userEmail = json['userEmail'];
    _date = json['date'];
  }

  String? _eventname;
  String? _userEmail;
  int? _date;

  String? get eventname => _eventname;
  String? get userEmail => _userEmail;
  int? get date => _date;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _eventname;
    map['userEmail'] = _userEmail;
    map['date'] = _date;


    return map;
  }
}