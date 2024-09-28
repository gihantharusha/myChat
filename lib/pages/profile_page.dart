import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:my_chat/models/user_model.dart';
import 'package:my_chat/service/firebase_storage.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/service/shared_pref.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  final ImagePicker imagePicker = ImagePicker();

  final userName = TextEditingController();
  final userDes = TextEditingController();

  updateProfileImage() async {
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    String? url = await FirebaseStorageService()
        .updateProfilePicture(File(file!.path), context, user!.profilePicture);

    await FirestoreService().updateProfilePicture(url!, user!.uid);
    loadUserData();
  }


  updateUserName() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change your title"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: userName,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                await FirestoreService().updateUserName(userName.text, user!.uid);
                loadUserData();
                GoRouter.of(context).pop();
                userName.clear();
              },
              child: Text(
                "Ok",
                style: AppTextStyles().kChatStyle.copyWith(
                  color: AppColors().kSeconderyColor
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: Text(
                "Cancle",
                style: AppTextStyles().kChatStyle.copyWith(
                  color: AppColors().kSeconderyColor
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  updateDescription() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change your description"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: userDes,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                await FirestoreService().updatedescription(userDes.text, user!.uid);
                loadUserData();
                GoRouter.of(context).pop();
                userName.clear();
              },
              child: Text(
                "Ok",
                style: AppTextStyles().kChatStyle.copyWith(
                  color: AppColors().kSeconderyColor
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: Text(
                "Cancle",
                style: AppTextStyles().kChatStyle.copyWith(
                  color: AppColors().kSeconderyColor
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  loadUserData() async {
    String? uid = await SharedPref().getUser();

    user = await FirestoreService().getUserDetails(uid!);
    userName.text = user!.name;
    userDes.text = user!.des;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  void dispose() {
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile page")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: AppColors().kGreyColor,
                      radius: 100,
                      child: user == null
                          ? Icon(
                              Icons.person,
                              size: 80,
                              color: AppColors().kBlackColor,
                            )
                          : SizedBox(
                              height: 200,
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
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          updateProfileImage();
                        },
                        icon: Icon(
                          Icons.image,
                          size: 40,
                          color: AppColors().kBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "User name:-",
                      style: AppTextStyles().kFriendDescription.copyWith(
                            fontSize: 22,
                            color: AppColors().kBlackColor,
                          ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: Text(
                        user == null ? "" : user!.name,
                        style: AppTextStyles().kFriendDescription.copyWith(
                              color: AppColors().kBlackColor,
                              fontSize: 22,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        updateUserName();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "User description:-",
                      style: AppTextStyles().kFriendDescription.copyWith(
                            fontSize: 22,
                            color: AppColors().kBlackColor,
                          ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 145,
                      child: Text(
                        user == null ? "" : user!.des,
                        style: AppTextStyles().kFriendDescription.copyWith(
                              color: AppColors().kBlackColor,
                              fontSize: 22,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        updateDescription();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
