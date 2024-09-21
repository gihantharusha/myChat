import 'package:flutter/material.dart';
import 'package:my_chat/models/user_model.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/service/shared_pref.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late User user;
  String? uid;
  final firestoreService = FirestoreService();
  final SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    uid = await sharedPref.getUser();

    print(user.name);
    user = await firestoreService.getUserDetails(uid!);
    setState(() async {
      
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile page") 
      ),
      body: Column(
        children: [
          CircleAvatar(
            child: Image.network(user.profilePicture),
          ),
          Text("data")
        ],
      ),
    );
  }
}