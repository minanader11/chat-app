import 'package:chat/core/models/user_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginFailureState extends LoginStates{
  String errMessage;
  LoginFailureState({required this.errMessage});
}
class LoginSuccessState extends LoginStates{
  MyUser user;
  LoginSuccessState({required this.user});
}