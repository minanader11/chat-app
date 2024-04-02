import 'package:chat/core/custom_text_field.dart';
import 'package:chat/core/dialog_utils.dart';
import 'package:chat/core/myTheme.dart';
import 'package:chat/features/login/presentation/view/login_screen.dart';
import 'package:chat/features/register/presentation/view_model/register_states.dart';
import 'package:chat/features/register/presentation/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';
  // TextEditingController userName = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();
  // TextEditingController confirmPassword = TextEditingController();
  // var formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel=RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterViewModel,RegisterStates>(bloc: viewModel,
      listener: (context, state) {
        if(state is RegisterLoadingState){
          DialogUtils.showLoading(context: context);
        } else if(state is RegisterFailureState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: state.errMessage,
              actionName: 'Ok',
              posActionFun: () {
                Navigator.of(context).pop();
              });
        } else if(state is RegisterSuccessState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Register Successfully',
              actionName: 'Ok',
              posActionFun: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              });

        }
      },
      builder: (context, state) => Stack(
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
                'Register',
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
                            child: Text('Create Account',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: MyTheme.blackColor),),
                          )),
                          CustomTextField(
                            label: 'Username',
                            controller: viewModel.userName,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Username';
                              }
                              return null;
                            },
                          ),
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
                                return 'Please enter Vaild Email';
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
                          CustomTextField(
                            obscureText: true,
                            label: 'ConfirmPassword',
                            controller: viewModel.confirmPassword,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Your Username';
                              }
                              if (text != viewModel.password.text) {
                                return "Confirm Password doesn't match Password";
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
                                  viewModel.registerFirebaseAuth();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Create An Account',
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
                             Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text(
                              "Already have an account",
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
