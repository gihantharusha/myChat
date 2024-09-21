import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future signUpUser(String email, String password) async {
    UserCredential result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;

    return user;
  }
}
