import 'package:chat/core/firebase_utils.dart';
import 'package:chat/core/models/message.dart';
import 'package:chat/features/room/presentation/view_model/room_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomViewModel extends Cubit<RoomStates> {
  RoomViewModel() :super(RoomInitialState());
   TextEditingController messageContorller=TextEditingController();
   late String username;
   late String roomId;
   late String userId;
  void insertMessage() {
    Message message = Message(dateTime: DateTime.now().microsecondsSinceEpoch,
        content: messageContorller.text,
        username: username,
        roomId: roomId,
        userId: userId);
    FirebaseUtils.insertMessage(message);
    messageContorller.clear();
    print('mina');
  }
  Stream<QuerySnapshot<Message>> getMessages(){
    return FirebaseUtils.getMessages(roomId);
  }
  void deleteRoom()async{
    emit(RoomRequestDeleteState());
    await FirebaseUtils.deleteRoom(roomId);
    emit(RoomDeleteState());
  }
}