import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';
import 'package:my_chat/widgets/message_card.dart';

class MessagePage extends StatefulWidget {
  final String imgUrl;
  final String name;
  final String uid;
  final String myId;
  const MessagePage({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.uid,
    required this.myId,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: AppTextStyles().kTitleStyle,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipOval(
              child: CircleAvatar(child: Image.network(widget.imgUrl)),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: FirestoreService().getAllChats(widget.uid),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var ds = snapshot.data!.docs[index];
                      return MessageCard(msg: ds['msg'], myId: widget.myId, senderId: ds['senderId']);
                    },
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors().kWhiteColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppColors().kGreyColor,
                    offset: const Offset(0, -2),
                    blurRadius: 10),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                        hintText: "Type your message",
                        fillColor: AppColors().kGreyColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors().kBlackColor, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors().kBlackColor, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirestoreService()
                          .addChat(widget.uid, msgController.text);
                      msgController.clear();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors().kSeconderyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.send,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
