import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String roomId;
  String userId;
  String username;
  String content;
  int dateTime;

  Message(
      {required this.dateTime,
      required this.content,
      required this.username,
      required this.roomId,
      required this.userId,
      this.id = ''});

  Message.fromJson(Map<String, dynamic> json)
      : this(
            content: json['content'],
            dateTime: json['dateTime'] as int ,
            roomId: json['roomId'],
            userId: json['userId'],
      username:json['username'],
  id: json['id']);
  Map<String,dynamic> toJson(){
    return {
      'content':content,
      'dateTime': dateTime,
      'roomId': roomId,
      'userId':userId,
      'username':username,
      'id':id
    };
  }
}
