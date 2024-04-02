import 'package:chat/core/dialog_utils.dart';
import 'package:chat/core/models/room_category.dart';
import 'package:chat/core/myTheme.dart';
import 'package:chat/features/add_room/presentation/view_model/add_room_states.dart';
import 'package:chat/features/add_room/presentation/view_model/add_room_view_model.dart';
import 'package:chat/features/home/presentation/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'addRoomScreen';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  var roomCategoryList = RoomCategory.getCategory();

  late RoomCategory selectedItem;
  AddRoomViewModel addRoomViewModel = AddRoomViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = roomCategoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
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
              'Add Room',
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 26),
            ),
            centerTitle: true,
          ),
          body: BlocListener<AddRoomViewModel, AddRoomStates>(
            bloc: addRoomViewModel,
            listener: (context, state) {
              if (state is AddRoomLoadingState) {
                DialogUtils.showLoading(context: context);
              } else if (state is AddRoomFailureState) {
                DialogUtils.hideLoading(context);
                DialogUtils.showMessage(
                    context: context,
                    message: state.errMessage,
                    actionName: 'Ok',
                    posActionFun: () {
                      Navigator.of(context).pop();
                    });
              } else if (state is AddRoomSuccessState) {
                DialogUtils.hideLoading(context);
                DialogUtils.showMessage(
                    context: context,
                    message: 'Room Added Successfully',
                    actionName: 'Ok',
                    posActionFun: () {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                    });
              }
            },
            child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: addRoomViewModel.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create New Room',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset('assets/images/room.png'),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: addRoomViewModel.roomTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Room title',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: MyTheme.greyColor)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter Room title';
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: Border.all(
                                    color: MyTheme.greyColor, width: 2)),
                            child: DropdownButton<RoomCategory>(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: selectedItem,
                              items: roomCategoryList
                                  .map((room) => DropdownMenuItem<RoomCategory>(
                                      value: room, child: Text(room.title)))
                                  .toList(),
                              onChanged: (value) {
                                selectedItem = value!;
                                setState(() {});
                              },
                              itemHeight: 50,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: addRoomViewModel.roomDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Room Description',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: MyTheme.greyColor)),
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter Room title';
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.2),
                            child: ElevatedButton(
                              onPressed: () {
                                addRoomViewModel.addRoom(selectedItem);
                              },
                              child: Text(
                                'Create room',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: MyTheme.whiteColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
