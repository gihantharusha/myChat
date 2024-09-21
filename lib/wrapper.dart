import 'package:flutter/material.dart';
import 'package:my_chat/pages/create_account.dart';
import 'package:my_chat/pages/home_page.dart';
import 'package:my_chat/service/shared_pref.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  final SharedPref sharedPref = SharedPref();

  String? uid;

  checkAvalability() async{
    uid = await sharedPref.getUser();
    setState(() {
    });
  }


  @override
  void initState() {
    super.initState();
    checkAvalability();
  }

  @override
  Widget build(BuildContext context) {
    
    return uid == null ? const CreateAccount() : const HomePage();
  }
}