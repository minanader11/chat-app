import 'package:chat/core/cubits/user_cubit/user_states.dart';
import 'package:chat/core/firebase_utils.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates>{
  UserCubit(): super(UserInitialState()){
    firebaseUser=FirebaseAuth.instance.currentUser;
    initUser();
  }
  MyUser? user;
  User? firebaseUser;
 initUser()async {
   if(firebaseUser!= null){
     user = await FirebaseUtils.readUserFromFirestore(firebaseUser?.uid ??'');
   }
 }
 void logout(){
   FirebaseAuth.instance.signOut();
 }
}