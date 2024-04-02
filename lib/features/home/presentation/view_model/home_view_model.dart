
import 'package:chat/core/firebase_utils.dart';
import 'package:chat/core/models/room.dart';
import 'package:chat/features/home/presentation/view_model/home_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates>{
  HomeViewModel():super(HomeInitialState());
  late List<Room?> roomList;
  void getRooms() async{
    emit(HomeLoadingState());
    try{
      QuerySnapshot<Room> querySnapshots= await FirebaseUtils.getRoomCollection().get();
      roomList = querySnapshots.docs.map((doc) => doc.data()).toList();
    emit(HomeSuccessState());

    } catch(e){
      emit(HomeFailureState(errMessage: e.toString()));
    }
  }
  void setupPushNotification()async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }
  Stream<QuerySnapshot<Room>> getRoomsfromFireStore(){
    return FirebaseUtils.readRoomFromFirestore();
  }
}