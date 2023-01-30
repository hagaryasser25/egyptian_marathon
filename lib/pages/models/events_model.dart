import 'package:flutter/cupertino.dart';

class Events {
  Events({
    String? appointment,
    String? place,
    String? code,
    String? id,
    String? date,
  }) {
    _appointment = appointment;
    _place = place;
    _code = code;
    _id = id;
    _date = date;
  }

  Events.fromJson(dynamic json) {
    _appointment = json['appointment'];
    _place = json['place'];
    _code = json['code'];
    _id = json['id'];
    _date = json['date'];
  }

  String? _appointment;
  String? _place;
  String? _code;
  String? _id;
  String? _date;

  String? get appointment => _appointment;
  String? get place => _place;
  String? get code => _code;
  String? get date => _date;
  String? get id => _id;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointment'] = _appointment;
    map['place'] = _place;
    map['code'] = _code;
    map['date'] = _date;
    map['id'] = _id;
    return map;
  }
}