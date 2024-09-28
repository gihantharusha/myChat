import 'package:flutter/material.dart';

class ProfileImageProvider extends ChangeNotifier{

  String imgUrl = "";

  String get getImgUrl => imgUrl;

  setImgUrl(String imgUrl) {
    this.imgUrl = imgUrl;
    notifyListeners();
  }
}