import 'package:chat/core/cubits/user_cubit/user_cubit.dart';
import 'package:chat/core/custom_text_field.dart';
import 'package:chat/core/dialog_utils.dart';
import 'package:chat/core/myTheme.dart';
import 'package:chat/features/home/presentation/view/home.dart';

import 'package:chat/features/login/presentation/view_model/login_states.dart';
import 'package:chat/features/login/presentation/view_model/login_view_model.dart';
import 'package:chat/features/register/presentation/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName='LoginScreen';

  LoginViewModel viewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    var userProvider=BlocProvider.of<UserCubit>(context);
    return   BlocConsumer<LoginViewModel,LoginStates>(bloc: viewModel,
      listener: (context, state) {
        if(state is LoginLoadingState){
          DialogUtils.showLoading(context: context);
        } else if(state is LoginFailureState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: state.errMessage,
              actionName: 'Ok',
              posActionFun: () {
                Navigator.of(context).pop();
              });
        } else if(state is LoginSuccessState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Login Successfully',
              actionName: 'Ok',
              posActionFun: () {
                userProvider.user=state.user;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(HomeScreen.routeName,(route) => false,);
              }
              );

        }
      },
      builder: (context, state) =>  Stack(
        children: [
          Container(
            color: MyTheme.whiteColor,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Login',
                style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 26),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                      key: viewModel.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          Align(alignment: Alignment.topLeft,child: Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: Text('Welcome Back!',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: MyTheme.blackColor),),
                          )),
                          CustomTextField(
                            label: 'Email',
                            controller: viewModel.email,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'Please enter Valid Email';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            obscureText: true,
                            label: 'Password',
                            controller: viewModel.password,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              if (text.trim().length < 6) {
                                return 'Password must contains at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: MyTheme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10))),
                                onPressed: () {
                                   viewModel.login();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: MyTheme.whiteColor),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: MyTheme.whiteColor,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);

                            },
                            child: Text(
                             'Create An Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyTheme.primaryColor),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
