import 'package:flutter/material.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';

class AppThemeStyle{
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles().kBtnStyle.copyWith(color: AppColors().kBlackColor),
        backgroundColor: AppColors().kSeconderyColor,
        side: BorderSide(color: AppColors().kBlackColor, width: 1,),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ), 
      ),
    ),
  );
}