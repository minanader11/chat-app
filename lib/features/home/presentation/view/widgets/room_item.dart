import 'package:chat/core/models/room.dart';
import 'package:chat/features/room/presentation/view/room_screen.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  Room room;

  RoomItem({required this.room});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    // TODO: implement build
    return InkWell(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoomScreen(room:room ),)),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration : BoxDecoration(
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
            Image.asset(
              'assets/images/${room.category}.png',
              fit: BoxFit.fill,
              height:height*0.15 ,
            ),
            Text(room.title),
          ],
        ),
      ),
    );
  }
}
