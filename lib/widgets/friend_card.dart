import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class FriendsCard extends StatelessWidget {
  final String name;
  final String description;
  final String imgUrl;
  final String uid;
  final String myId;
  const FriendsCard({
    super.key,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.uid,
    required this.myId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push("/chatPage", extra: {"name": name, "imgUrl": imgUrl, "uid": uid, "myId": myId});
      },
      child: Card(
        color: AppColors().kSeconderyColor,
        elevation: 10,
        shadowColor: AppColors().kBlackColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(
              name,
              style: AppTextStyles().kFriendNameStyle,
            ),
            subtitle: Text(
              description,
              style: AppTextStyles().kFriendDescription,
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors().kGreyColor,
              child: imgUrl == ""
                  ? const Icon(Icons.person)
                  : SizedBox(
                      height: 250,
                      child: ClipOval(
                        child: InstaImageViewer(
                          child: Image(
                            image: Image.network(
                              imgUrl,
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
