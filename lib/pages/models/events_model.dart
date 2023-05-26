import 'package:flutter/cupertino.dart';

class Events {
  Events({
    String? appointment,
    String? place,
    String? id,
    String? date,
    String? conditions,
    String? name,
    String? organizer,
    String? price,
    String? time,
    String? type,

  }) {
    _appointment = appointment;
    _place = place;
    _id = id;
    _date = date;
    _conditions = conditions;
    _name = name;
    _organizer = organizer;
    _price = price;
    _time = time;
    _type = type;
    
  }

  Events.fromJson(dynamic json) {
    _appointment = json['appointment'];
    _place = json['place'];
    _id = json['id'];
    _date = json['date'];
    _conditions = json['conditions'];
    _name = json['name'];
    _organizer = json['organizer'];
    _price = json['price'];
    _time = json['time'];
    _type = json['type'];
  }

  String? _appointment;
  String? _place;
  String? _id;
  String? _date;
  String? _conditions;
  String? _name;
  String? _organizer;
  String? _price;
  String? _time;
  String? _type;

  String? get appointment => _appointment;
  String? get place => _place;
  String? get date => _date;
  String? get id => _id;
  String? get conditions => _conditions;
  String? get name => _name;
  String? get organizer => _organizer;
  String? get price => _price;
  String? get time => _time;
  String? get type => _type;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appointment'] = _appointment;
    map['place'] = _place;
    map['date'] = _date;
    map['id'] = _id;
    map['conditions'] = _conditions;
    map['name'] = _name;
    map['organizer'] = _organizer;
    map['price'] = _price;
    map['time'] = _time;
    map['type'] = _type;
    return map;
  }
}