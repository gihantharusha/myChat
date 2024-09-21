import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    required this.imgUrl, required this.uid,
  });

  addName(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: AppColors().kBlackColor,
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: AppColors().kBlackColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: AppColors().kBlackColor,
                        width: 1,
                      ),
                    ),
                    hintText: "Friend name",
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FirestoreService().addFriend(name, uid, imgUrl, description);
                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      "Add friend",
                      style: AppTextStyles().kBtnStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
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
