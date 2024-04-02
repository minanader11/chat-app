abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeFailureState extends HomeStates{
  String errMessage;
  HomeFailureState({required this.errMessage});
}
class HomeSuccessState extends HomeStates{}