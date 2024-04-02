import 'package:chat/core/firebase_utils.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:chat/features/register/presentation/view_model/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewModel extends Cubit<RegisterStates>{
  RegisterViewModel():super(RegisterInitialState());
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();
  void registerFirebaseAuth()async{
    bool validate = formKey.currentState!.validate();
    if (validate) {
       emit(RegisterLoadingState());
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        MyUser user = MyUser(
            email: email.text,
            userName: userName.text,
            id: credential.user?.uid ?? '');
        FirebaseUtils.addUserToFirestore(user);
       emit(RegisterSuccessState());

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(RegisterFailureState(errMessage:'The password provided is too weak.' ));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          emit(RegisterFailureState(errMessage: 'The account already exists for that email.'));
          print('The account already exists for that email.');
        }
      } catch (e) {
        emit(RegisterFailureState(errMessage: e.toString()));
        print(e);
      }
    }
  }
}