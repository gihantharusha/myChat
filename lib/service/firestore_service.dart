import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat/models/friend_model.dart';
import 'package:my_chat/models/message_model.dart';
import 'package:my_chat/service/shared_pref.dart';
import '../models/user_model.dart';
import 'package:random_string/random_string.dart';

class FirestoreService {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  
  CollectionReference chatroom = FirebaseFirestore.instance.collection("chatroom");

  final SharedPref sp = SharedPref();

  Future<void> addUser(String name, String des, String email, String pass,
      String pp, String uid) async {
    User user = User(
        name: name,
        des: des,
        email: email,
        pass: pass,
        profilePicture: pp,
        uid: uid);

    await userCollection.doc(uid).set(user.toJson());
  }

  Future<User> getUserDetails(String uid) async {
    return userCollection
        .doc(uid)
        .collection("info")
        .doc("user")
        .get()
        .then((DocumentSnapshot doc) {
      return User(
          uid: doc['uid'],
          name: doc['name'],
          des: doc['des'],
          email: doc['email'],
          pass: doc['pass'],
          profilePicture: doc['profilePicture']);
    });
  }

  Stream<QuerySnapshot> getFriendsByName(String name) {
    return userCollection
        .orderBy('name')
        .startAt([name]).endAt([name + "\uf8ff"]).snapshots();
  }

  Future<void> addFriend(
      String name, String uid, String profilePicture, String des) async {
    String? myId = await sp.getUser();
    FriendModel friendModel = FriendModel(
        name: name, description: des, imgUrl: profilePicture, uid: uid);
    await userCollection
        .doc(myId)
        .collection("friends")
        .add(friendModel.toJson());
  }

  Stream<QuerySnapshot> getAllFriends() async* {
    String? myId = await SharedPref().getUser();
    yield* userCollection.doc(myId).collection("friends").snapshots();
  }

  Future<void> addChat(String fId, String msg) async {
    String? myId = await SharedPref().getUser();
    List ids = [fId, myId];
    ids.sort();
    String chatRoomId = ids.join("_");
    String randomId = randomAlphaNumeric(20);
    MessageModel messageModel =
        MessageModel(msg: msg, timestamp: DateTime.now(), chatId: randomId, senderId: myId!);
    chatroom
        .doc(chatRoomId)
        .collection("chats")
        .doc(randomId)
        .set(messageModel.toJson());
  }

  Stream<QuerySnapshot<Object?>> getAllChats(String fId) async* {
    String? myId = await SharedPref().getUser();
    List ids = [fId, myId];
    ids.sort();
    String chatRoomId = ids.join("_");
    yield* chatroom
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("timestamp")
        .snapshots();
  }
}
