import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_chat/service/auth_service.dart';
import 'package:my_chat/service/firebase_storage.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/service/shared_pref.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final ImagePicker _imagePicker = ImagePicker();

  final FirebaseStorageService firebaseStorageService =
      FirebaseStorageService();

  final AuthService authService = AuthService();

  final FirestoreService firestoreService = FirestoreService();

  final SharedPref sharedPref = SharedPref();

  String? imgUrl;
  late String uid;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> pickImageFromFile() async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (res != null) {
        imgUrl =
            // ignore: use_build_context_synchronously
            await firebaseStorageService.uploadFile(File(res.path), context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text("Failed pick image"),
        ),
      );
    }
  }

  Future<void> signUpUser() async {
    if (!_nameController.text.isEmpty &
        !_emailController.text.isEmpty &
        !_passController.text.isEmpty) {
      dynamic user = await authService.signUpUser(
          _emailController.text, _passController.text);

      if (user != null) {
        uid = user.uid;
        await addUser(uid);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[700],
          content: const Text("Please enter your all details"),
        ),
      );
    }
  }

  Future<void> addUser(String uid) async {
    await firestoreService.addUser(_nameController.text, _desController.text,
        _emailController.text, _passController.text, imgUrl == null ? " " : imgUrl!, uid);
    await addUserToSharedPref(uid);
  }

  Future<void> addUserToSharedPref(String uid) async {
    await sharedPref.addUser(uid);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Your account is created"),
      ),
    );
    GoRouter.of(context).go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppColors().kWhiteColor,
                    border: Border.all(
                      color: AppColors().kBlackColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors().kBlackColor,
                        offset: const Offset(5, 5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 40,
                    ),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: AppColors().kGreyColor,
                              radius: 40,
                              child: imgUrl == null
                                  ? Icon(
                                      Icons.person,
                                      size: 70,
                                      color: AppColors().kBlackColor,
                                    )
                                  : SizedBox(
                                      height: 200,
                                      child: ClipOval(
                                        child: Image.network(
                                          imgUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                onPressed: () async {
                                  await pickImageFromFile();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.photo,
                                  color: AppColors().kBlackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: "User name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors().kMainColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kSeconderyColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kMainColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: _desController,
                            decoration: InputDecoration(
                              hintText: "User description",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors().kMainColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kSeconderyColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kMainColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "User email",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors().kMainColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kSeconderyColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kMainColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: _passController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "User password",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors().kMainColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kSeconderyColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors().kMainColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await signUpUser();
                            },
                            child: Text(
                              "Submit",
                              style: AppTextStyles().kBtnStyle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
