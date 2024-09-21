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
      print("ok");
      imgUrl = await reference.getDownloadURL();
      print("ok2");
    } catch (e) {
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
}
