import 'package:chat/core/cubits/user_cubit/user_cubit.dart';
import 'package:chat/core/myTheme.dart';
import 'package:chat/features/add_room/presentation/view/add_room.dart';

import 'package:chat/features/home/presentation/view/home.dart';
import 'package:chat/features/login/presentation/view/login_screen.dart';
import 'package:chat/features/register/presentation/view/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiBlocProvider(providers: [BlocProvider<UserCubit>(create: (context) => UserCubit()..initUser(),)],child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userProvider=BlocProvider.of<UserCubit>(context);
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyTheme.lightMode,
      routes: {LoginScreen.routeName: (context) => LoginScreen(),
      RegisterScreen.routeName:(context) => RegisterScreen(),
      HomeScreen.routeName:(context) => HomeScreen(),
        AddRoomScreen.routeName:(context) => AddRoomScreen(),
      },
      initialRoute: userProvider.firebaseUser == null ?
      LoginScreen.routeName
      :HomeScreen.routeName,
    );
  }
}


