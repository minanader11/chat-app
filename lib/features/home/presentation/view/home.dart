import 'package:chat/core/cubits/user_cubit/user_cubit.dart';
import 'package:chat/core/models/room.dart';
import 'package:chat/core/myTheme.dart';
import 'package:chat/features/add_room/presentation/view/add_room.dart';
import 'package:chat/features/home/presentation/view/widgets/room_item.dart';
import 'package:chat/features/home/presentation/view_model/home_states.dart';
import 'package:chat/features/home/presentation/view_model/home_view_model.dart';
import 'package:chat/features/login/presentation/view/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String routeName = 'chat';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewModel.getRooms();
    homeViewModel.setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    var userCubit = BlocProvider.of<UserCubit>(context);
    return Stack(children: [
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
          actions: [
            InkWell(onTap: () {
              userCubit.firebaseUser=null;
              userCubit.user=null;
              userCubit.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
              child: Icon(
                Icons.logout,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          title: Text(
            'Chat App',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 26),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddRoomScreen.routeName);
            },
            child: Icon(Icons.add)),
        body:StreamBuilder<QuerySnapshot<Room>>(
          stream: homeViewModel.getRoomsfromFireStore(),
          builder: ( context,
              snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }

            List<Room> rooms= snapshot.data?.docs.map((doc) => doc.data()).toList() ??[];
            if(rooms.isEmpty){
              return Center(child: Text('No rooms'));
            }
            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: rooms.length,itemBuilder: (context, index) => RoomItem(room: rooms[index]),);
          },
        ),
      )
    ]);
  }
}
