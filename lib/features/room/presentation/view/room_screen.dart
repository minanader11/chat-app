import 'package:chat/core/cubits/user_cubit/user_cubit.dart';
import 'package:chat/core/models/message.dart';
import 'package:chat/core/models/room.dart';
import 'package:chat/core/myTheme.dart';
import 'package:chat/features/home/presentation/view/home.dart';
import 'package:chat/features/room/presentation/view/widgets/message_widget.dart';
import 'package:chat/features/room/presentation/view_model/room_states.dart';
import 'package:chat/features/room/presentation/view_model/room_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomScreen extends StatefulWidget {
  Room room;

  RoomScreen({required this.room});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  RoomViewModel roomViewModel = RoomViewModel();

  @override
  Widget build(BuildContext context) {
    var userCubit = BlocProvider.of<UserCubit>(context);
    roomViewModel.username = userCubit.user!.userName;
    roomViewModel.userId = userCubit.user!.id;
    roomViewModel.roomId = widget.room.id;
    return BlocConsumer<RoomViewModel, RoomStates>(listener:  (context, state) {
      if(state is RoomDeleteState){
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      }
    },
      bloc: roomViewModel,
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
            appBar: AppBar(actions: [InkWell(onTap: () {
              roomViewModel.deleteRoom();
            },child: Icon(Icons.delete))],
              backgroundColor: Colors.transparent,
              title: Text(
                widget.room.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 26),
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: roomViewModel.getMessages(),
                      builder: ( context,
                           snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(),);
                        }
                         List<Message> messages= snapshot.data?.docs.map((doc) => doc.data()).toList() ??[];
                        return ListView.builder(itemCount: messages.length,itemBuilder: (context, index) => MessageWidget(message: messages[index]),);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: roomViewModel.messageContorller,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10))),
                              hintText: 'Send a Message',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyTheme.greyColor)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            roomViewModel.insertMessage();
                          },
                          child: Row(
                            children: [
                              Text(
                                'Send',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: MyTheme.whiteColor,
                                        fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.send,
                                color: MyTheme.whiteColor,
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
