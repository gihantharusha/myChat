import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:my_chat/models/user_model.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/service/shared_pref.dart';
import 'package:my_chat/utils/colors.dart';
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
    user = await firestoreService.getUserDetails(uid!);
    setState(() {});
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors().kGreyColor,
              child: user == null
                  ? const Icon(Icons.person)
                  : SizedBox(
                    width: 40,
                    height: 40,
                      child: ClipOval(
                        child: InstaImageViewer(
                          child: Image(
                            image: Image.network(
                              user!.profilePicture,
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: StreamBuilder(
                  stream: FirestoreService().getAllFriends(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("You have not friends yet"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var ds = snapshot.data!.docs[index];
                          return FriendsCard(
                              name: ds['name'],
                              description: ds['des'],
                              imgUrl: ds['imgUrl'],
                              uid: ds['uid'],
                              myId: uid!);
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
