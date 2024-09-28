import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat/utils/routers.dart';
import 'package:my_chat/utils/theme.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "MyChat",
      debugShowCheckedModeBanner: false,
      theme: AppThemeStyle().lightTheme,
      routerConfig: Routers().routers,
    );
  }
}
