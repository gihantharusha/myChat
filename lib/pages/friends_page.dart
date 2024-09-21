import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/models/user_model.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/service/shared_pref.dart';
import 'package:my_chat/utils/text_styles.dart';
import 'package:my_chat/widgets/friend_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  User? user;
  String? uid;
  final firestoreService = FirestoreService();
  final SharedPref sharedPref = SharedPref();

  loadUserData() async {
    uid = await sharedPref.getUser();

    print(user!.name);
    setState(() async {
      user = await firestoreService.getUserDetails(uid!);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyChat",
          style: AppTextStyles().kAppBarTitleStyle,
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.731,
              child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: FirestoreService().getAllFriends(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData){
                    return const Center(
                      child: Text("You have not friends yet"),
                    );
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      var ds = snapshot.data!.docs[index];
                      return FriendsCard(name: ds["name"], description: ds['des'], imgUrl: ds['imgUrl'], uid: ds['uid'], myId: uid!);
                    },
                  );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
