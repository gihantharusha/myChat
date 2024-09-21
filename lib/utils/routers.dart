import 'package:go_router/go_router.dart';
import 'package:my_chat/pages/chat_page.dart';
import 'package:my_chat/pages/home_page.dart';
import 'package:my_chat/wrapper.dart';

class Routers {
  final routers = GoRouter(
    initialLocation: "/",
    routes: [

      GoRoute(
        path: "/",
        builder: (context, state) => const Wrapper(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) {
          return const HomePage();
        },
      ),

      GoRoute(
        path: "/chatPage",
        builder: (contex, state) {
          final name = (state.extra as Map<String, dynamic>) ['name'] as String;
          final imgUrl = (state.extra as Map<String, dynamic>) ['imgUrl'] as String;
          final uid = (state.extra as Map<String, dynamic>) ["uid"] as String;
          final myId = (state.extra as Map<String, dynamic>) ["myId"] as String;
          return MessagePage(name: name, imgUrl: imgUrl, uid: uid, myId: myId,);
        },
      ),
    ],
  );
}
