import 'package:flutter/material.dart';
import 'package:my_chat/pages/friends_page.dart';
import 'package:my_chat/pages/profile_page.dart';
import 'package:my_chat/pages/search_friends.dart';
import 'package:my_chat/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ChatPage(),
          SearchFirends(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors().kGreyColor,
              offset: const Offset(0, -3),
              blurRadius: 15,
            ),
          ],
        ),
        child: BottomNavigationBar(
          unselectedItemColor: AppColors().kBlackColor,
          selectedItemColor: AppColors().kBottomNavigationSelectedColor,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
