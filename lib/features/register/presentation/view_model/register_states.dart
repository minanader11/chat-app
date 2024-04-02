abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterFailureState extends RegisterStates{
  String errMessage;
  RegisterFailureState({required this.errMessage});
}
class RegisterSuccessState extends RegisterStates{}