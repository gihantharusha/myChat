import 'package:flutter/material.dart';
import 'package:my_chat/service/firestore_service.dart';
import 'package:my_chat/utils/colors.dart';
import 'package:my_chat/utils/text_styles.dart';

class SearchFriendCard extends StatelessWidget {
  final String name;
  final String description;
  final String imgUrl;
  final String uid;
  const SearchFriendCard({
    super.key,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.uid,
  });

  addName(BuildContext context) {
    FirestoreService().addFriend(name, uid, imgUrl, description);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Your friend is added"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        addName(context);
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
                      height: 200,
                      child: ClipOval(
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
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
