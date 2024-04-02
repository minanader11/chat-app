abstract class AddRoomStates{}
class AddRoomInitialState extends AddRoomStates{}
class AddRoomLoadingState extends AddRoomStates{}
class AddRoomFailureState extends AddRoomStates{
  String errMessage;
  AddRoomFailureState({required this.errMessage});
}
class AddRoomSuccessState extends AddRoomStates{}