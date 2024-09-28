import 'package:flutter/material.dart';

class ProfileImageProvider extends ChangeNotifier{

  String _imgUrl = "";

  String get getImgUrl => _imgUrl;

  setImgUrl(String imgUrl) {
    _imgUrl = imgUrl;
    notifyListeners();
  }
}