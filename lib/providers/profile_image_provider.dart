import 'package:flutter/material.dart';

class ProfileImageProvider extends ChangeNotifier{

  String imgUrl = "";

  String get getImgUrl => imgUrl;

  void setImgUrl(String imgUrl) {
    this.imgUrl = imgUrl;
    notifyListeners();
  }
}