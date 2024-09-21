import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/models/friend_model.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/service/shared_pref.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';
import 'package:my_chat/widgets/search_friend_card.dart';

class SearchFirends extends StatefulWidget {
  const SearchFirends({super.key});

  @override
  State<SearchFirends> createState() => _SearchFirendsState();
}

class _SearchFirendsState extends State<SearchFirends> {
  var name = '';
  var uid;

  bool isClicked = false;

  List<FriendModel> allFriends = [];
  List<FriendModel> filterFrinds = [];

  final FirestoreService firestoreService = FirestoreService();

  final SharedPref sharedPref = SharedPref();

  loadUid() async{
    uid = await sharedPref.getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUid();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search friends",
          style: AppTextStyles().kFriendNameStyle.copyWith(
                fontSize: 20,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 45,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.search),
                            hintText: "Search your firiends",
                            hintStyle: AppTextStyles().kFriendDescription,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().kBlackColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                stream: firestoreService.getFriendsByName(name),
                builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var documentSnapshot = snapshot.data!.docs[index];
                        return uid! == documentSnapshot['uid'] ? const SizedBox() : SearchFriendCard(
                          name: documentSnapshot['name'],
                          description: documentSnapshot['des'],
                          imgUrl: documentSnapshot['profilePicture'],
                          uid: documentSnapshot['uid'],
                        );
                      },
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
