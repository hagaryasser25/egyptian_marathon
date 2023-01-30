import 'package:flutter/cupertino.dart';

class BikeBookings {
  BikeBookings({
    String? bikeCode,
    String? uid,
    String? date,
    int? adminProfit,
    int? rentedProfit,
    int? profit,
    String? amount,
    String? id,
    String? userEmail,
    int? hours,
    String? ID,
  }) {
    _bikeCode = bikeCode;
    _uid = uid;
    _date = date;
    _adminProfit = adminProfit;
    _rentedProfit = rentedProfit;
    _profit = profit;
    _amount = amount;
    _id = id;
    _userEmail = userEmail;
    _hours = hours;
    _ID = ID;
  }

  BikeBookings.fromJson(dynamic json) {
    _bikeCode = json['bikeCode'];
    _uid = json['bikeUid'];
    _date = json['date'];
    _adminProfit = json['adminProfit'];
    _rentedProfit = json['rentedProfit'];
    _profit = json['profit'];
    _amount = json['amount'];
    _id = json['code'];
    _userEmail = json['userEmail'];
    _hours = json['hours'];
    _ID = json['id'];
  }

  String? _bikeCode;
  String? _uid;
  String? _date;
  int? _adminProfit;
  int? _rentedProfit;
  int? _profit;
  String? _amount;
  String? _id;
  String? _userEmail;
  int? _hours;
  String? _ID;

  String? get bikeCode => _bikeCode;
  String? get uid => _uid;
  String? get date => _date;
  int? get adminProfit => _adminProfit;
  int? get rentedProfit => _rentedProfit;
  int? get profit => _profit;
  String? get amount => _amount;
  String? get id => _id;
  String? get userEmail => _userEmail;
  int? get hours => _hours;
  String? get ID => _ID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bikeCode'] = _bikeCode;
    map['bikeUid'] = _uid;
    map['date'] = _date;
    map['adminProfit'] = _adminProfit;
    map['rentedProfit'] = _rentedProfit;
    map['profit'] = _profit;
    map['amount'] = _amount;
    map['code'] = _id;
    map['userEmail'] = _userEmail;
    map['hours'] = _hours;
    map['id'] = _ID;

    return map;
  }
}
