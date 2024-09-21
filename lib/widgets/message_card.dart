import 'package:flutter/material.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';

class MessageCard extends StatelessWidget {
  final String msg;
  final String myId;
  final String senderId;
  const MessageCard({super.key, required this.msg, required this.myId, required this.senderId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: senderId == myId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors().kBlackColor,
                  offset: const Offset(1, 3),
                  blurRadius: 5,
                ),
              ],
              borderRadius: senderId == myId ? 
              const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ) : 
              const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: senderId == myId ? AppColors().kSeconderyColor : AppColors().kMainColor,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(msg, style: AppTextStyles().kChatStyle,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
