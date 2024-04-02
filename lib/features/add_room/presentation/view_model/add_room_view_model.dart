import 'package:chat/core/firebase_utils.dart';
import 'package:chat/core/models/room.dart';
import 'package:chat/core/models/room_category.dart';
import 'package:chat/features/add_room/presentation/view_model/add_room_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRoomViewModel extends Cubit<AddRoomStates>{
  AddRoomViewModel():super(AddRoomInitialState());
  TextEditingController roomTitle = TextEditingController();
  TextEditingController roomDescription = TextEditingController();

  var formKey = GlobalKey<FormState>();
  void addRoom(RoomCategory roomCategory){
    bool validate = formKey.currentState!.validate();
    if(validate){
      emit(AddRoomLoadingState());
      try{
        Room room= Room(title: roomTitle.text, id: '', category: roomCategory.id, description: roomDescription.text);
        FirebaseUtils.addRoomToFirestore(room);
        emit(AddRoomSuccessState());
      }catch(e){
        emit(AddRoomFailureState(errMessage: e.toString()));
      }
    }
  }
}