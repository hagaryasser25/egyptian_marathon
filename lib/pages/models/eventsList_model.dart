import 'package:flutter/cupertino.dart';

class EventBookings {
  EventBookings({
    String? eventCode,
    String? userEmail,
    int? date,

  }) {
    _eventCode = eventCode;
    _userEmail = userEmail;
    _date = date;
  }

  EventBookings.fromJson(dynamic json) {
    _eventCode = json['code'];
    _userEmail = json['userEmail'];
    _date = json['date'];
  }

  String? _eventCode;
  String? _userEmail;
  int? _date;

  String? get eventCode => _eventCode;
  String? get userEmail => _userEmail;
  int? get date => _date;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _eventCode;
    map['userEmail'] = _userEmail;
    map['date'] = _date;


    return map;
  }
}