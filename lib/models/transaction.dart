
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionClass {
  String name;
  String operator;
  Timestamp time;
  bool paid;
  String number;
  double amount;
  String docId;

  TransactionClass(
      {this.name,
        this.operator,
        this.time,
        this.paid,
        this.number,
        this.amount});

  TransactionClass.fromJson(Map<String, dynamic> json,String doc) {
    name = json['name'];
    operator = json['operator'];
    time = json['time'];
    paid = json['paid'];
    number = json['number'];
    amount = double.parse(json['amount'].toString());
    docId = doc;
  }

//  TransactionClass.fromDart(Map<String, dynamic> json) {
//    name = json['name'];
//    operator = json['operator'];
//    time = json['time'];
//    paid = json['paid'];
//    number = json['number'];
//    amount = double.parse(json['amount'].toString());
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['operator'] = this.operator;
    data['time'] = this.time;
    data['paid'] = this.paid;
    data['number'] = this.number;
    data['amount'] = this.amount;
    return data;
  }
}