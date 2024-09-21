import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> addUser(String uid) async{
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString("uid", uid);

    print(pref.getString("uid"));
  }

  Future<String?> getUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("uid"));
    return pref.getString('uid');
  }
}