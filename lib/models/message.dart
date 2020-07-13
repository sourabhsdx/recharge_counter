import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  String sender;
  String senderId;
  Timestamp sentAt;

  Message({this.message, this.sender, this.senderId, this.sentAt});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sender = json['sender'];
    senderId = json['senderId'];
    sentAt = json['sentAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['sender'] = this.sender;
    data['senderId'] = this.senderId;
    data['sentAt'] = this.sentAt;
    return data;
  }
}