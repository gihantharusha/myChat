import 'package:flutter/material.dart';
import 'package:my_chat/utils/colors.dart';

class AppTextStyles {
  final TextStyle kAppBarTitleStyle = TextStyle(
    fontSize: 32,
    color: AppColors().kMainColor,
    fontWeight: FontWeight.w900,
  );

  final TextStyle kBtnStyle = TextStyle(
    fontSize: 20,
    color: AppColors().kBlackColor,
    fontWeight: FontWeight.w600,
  );

  final TextStyle kFriendNameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors().kBlackColor,
  );

  final TextStyle kFriendDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors().kBlackColor.withOpacity(0.5),
  );

  final TextStyle kTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors().kBlackColor,
  );

  final TextStyle kChatStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors().kBlackColor.withOpacity(0.8),
  );

}
