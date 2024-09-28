import 'package:flutter/material.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';

class MessageCard extends StatefulWidget {
  final String msg;
  final String myId;
  final String senderId;
  const MessageCard(
      {super.key,
      required this.msg,
      required this.myId,
      required this.senderId});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  popMenu() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              widget.msg,
              style: AppTextStyles()
                  .kTitleStyle
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: widget.senderId == widget.myId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPress: () {
              popMenu();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors().kBlackColor,
                    offset: const Offset(1, 3),
                    blurRadius: 5,
                  ),
                ],
                borderRadius: widget.senderId == widget.myId
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                color: widget.senderId == widget.myId
                    ? AppColors().kSeconderyColor
                    : AppColors().kMainColor,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    widget.msg,
                    style: AppTextStyles().kChatStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
