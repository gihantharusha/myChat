import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageService {
  Future<String?> uploadFile(File image, BuildContext context) async {

    String? imgUrl;

    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("profile/${DateTime.now().microsecondsSinceEpoch}.png");
      await reference.putFile(image);
      imgUrl = await reference.getDownloadURL();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text("Failed upload image"),
        ),
      );
    }

    return imgUrl;
  }

  Future<String?> updateProfilePicture(File image, BuildContext context, String oldUrl) async{
    String? imgUrl;
    try {

      // String oldFilePath = oldUrl.replaceAll(new RegExp(r"https://console.firebase.google.com/u/0/project/my-chat-590b1/storage/my-chat-590b1.appspot.com/files/~2Fprofile"), "");
      // String oldFilePath = oldUrl.replaceAll(oldUrl, "");

      // await FirebaseStorage.instance.ref().child(oldUrl).delete();

      Reference reference = FirebaseStorage.instance.ref().child("profile/${DateTime.now().microsecondsSinceEpoch}.png");      

      await reference.putFile(image);

      imgUrl = await reference.getDownloadURL();
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text("Failed update image"),
        ),
      );
    }

    return imgUrl;
  }

}
