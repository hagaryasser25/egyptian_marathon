import 'package:flutter/cupertino.dart';

class Bikes {
  Bikes({
    String? amount,
    String? area,
    String? code,
    String? id,
    String? imageUrl,
    int? price,
    String? type,
    String? uid,
    String? rentedName,
    String? rentedPhone,
    int? rating,
  }) {
    _amount = amount;
    _area = area;
    _code = code;
    _id = id;
    _imageUrl = imageUrl;
    _price = price;
    _type = type;
    _uid = uid;
    _rentedName = rentedName;
    _rentedPhone = rentedPhone;
    _rating = rating;
  }

  Bikes.fromJson(dynamic json) {
    _amount = json['amount'];
    _area = json['area'];
    _code = json['code'];
    _id = json['id'];
    _imageUrl = json['imageUrl'];
    _price = json['price'];
    _type = json['type'];
    _uid = json['uid'];
    _rentedName = json['rentedName'];
    _rentedPhone = json['rentedPhone'];
    _rating = json['rating'];
  }

  String? _amount;
  String? _area;
  String? _code;
  String? _id;
  String? _imageUrl;
  int? _price;
  String? _type;
  String? _uid;
  String? _rentedName;
  String? _rentedPhone;
  int? _rating;


  String? get amount => _amount;
  String? get area => _area;
  String? get code => _code;
  String? get imageUrl => _imageUrl;
  String? get id => _id;
  int? get price => _price;
  String? get type => _type;
  String? get uid => _uid;
  String? get rentedName => _rentedName;
  String? get rentedPhone => _rentedPhone;
  int? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    map['area'] = _area;
    map['code'] = _code;
    map['imageUrl'] = _imageUrl;
    map['id'] = _id;
    map['type'] = _type;
    map['price'] = _price;
    map['uid'] = _uid;
    map['rentedName'] = _rentedName;
    map['rentedPhone'] = _rentedPhone;
    map['rating'] = _rating;

    return map;
  }
}
