import 'package:chat/core/models/message.dart';
import 'package:chat/core/models/room.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
      fromFirestore: (snapshot, _) => MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (user, _) => user.toFireStore(user),
    );
  }

  static Future<void> addUserToFirestore(MyUser user) {
    CollectionReference<MyUser> userCollection = getUserCollection();
    return userCollection.doc(user.id).set(user);
  }
  static Future<MyUser?>readUserFromFirestore(String id)async {
    var querySnapshots=await getUserCollection().doc(id).get();
    return querySnapshots.data();
  }
  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance.collection('rooms').withConverter<Room>(
      fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
      toFirestore: (room, _) =>room.toJson(room),
    );
  }
  static Future<void> addRoomToFirestore(Room room) {

      CollectionReference<Room>  roomCollection = getRoomCollection();
      DocumentReference<Room> roomDoc=roomCollection.doc();
      room.id = roomDoc.id;
      print('task id :${room.id}');

      return  roomDoc.set(room);

  }
  static Stream<QuerySnapshot<Room>>readRoomFromFirestore() {
    var documentSnapshot= getRoomCollection().snapshots();
    return documentSnapshot;
  }
  static Future<void> deleteRoom(String roomId){
    return getRoomCollection().doc(roomId).delete();
  }
  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance.collection('rooms').doc(roomId).collection('messages').withConverter<Message>(
      fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
      toFirestore: (message, _) => message.toJson(),
    );
  }
 static Future<void>  insertMessage(Message message){
   var docRef= getMessageCollection(message.roomId).doc();
   message.id=docRef.id;
   return docRef.set(message);
  }
  static Stream<QuerySnapshot<Message>> getMessages(String roomId){
    return getMessageCollection(roomId).orderBy('dateTime').snapshots();
  }

}