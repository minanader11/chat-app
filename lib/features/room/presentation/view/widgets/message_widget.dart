import 'package:chat/core/cubits/user_cubit/user_cubit.dart';
import 'package:chat/core/models/message.dart';
import 'package:chat/core/myTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var userCubit=BlocProvider.of<UserCubit>(context);
    return message.userId==userCubit.user!.id
        ? SendMessage(message: message)
        :ReceiveMessage(message: message);
  }
}

class SendMessage extends StatelessWidget {
  Message message ;

  SendMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    DateFormat dateFormat=DateFormat("HH:mm");
    String messageDate= dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(message.dateTime));
    return Column(crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Container(padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                ),


          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('me',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyTheme.greyColor,fontSize: 12),),
              Text(message.content,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyTheme.whiteColor),),
              Padding(
                padding:  EdgeInsets.only(left: width*0.3),
                child: Text(messageDate.toString(),style:  Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyTheme.blackColor.withOpacity(0.7),fontSize: 13) ,),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

class ReceiveMessage extends StatelessWidget {
  Message message ;
  ReceiveMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    DateFormat dateFormat=DateFormat("HH:mm");
    String messageDate= dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(message.dateTime));
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(message.username,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14),),
        Container(padding:  EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade500,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),


          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(message.content,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyTheme.whiteColor),),
              Padding(
                padding:  EdgeInsets.only(left: width*0.3),
                child: Text(messageDate.toString(),style:  Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyTheme.blackColor,fontSize: 13) ,),
              )
            ],
          ),

        ),

      ],
    );
  }
}
