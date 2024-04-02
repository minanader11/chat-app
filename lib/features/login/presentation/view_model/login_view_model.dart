import 'package:chat/core/firebase_utils.dart';
import 'package:chat/features/login/presentation/view_model/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Cubit<LoginStates>{
  LoginViewModel(): super(LoginInitialState());

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var formKey = GlobalKey<FormState>();
  void login() async {
    bool validate = formKey.currentState!.validate();
    if (validate) {
    emit(LoginLoadingState());
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email.text, password: password.text);

        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
  emit(LoginSuccessState(user: user!));

      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
           emit(LoginFailureState(errMessage: 'No user found for that email.'));
          print('No user found for that email.');
        }
      }catch (e){
        emit(LoginFailureState(errMessage: e.toString()));
      }
    }
  }

}