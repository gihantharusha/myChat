class User {
  final String name;
  final String des;
  final String email;
  final String pass;
  final String profilePicture;
  final String uid;

  User({
    required this.uid,
    required this.name,
    required this.des,
    required this.email,
    required this.pass,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "des": des,
      "email": email,
      "pass": pass,
      "profilePicture": profilePicture,
      "uid": uid,
    };
  }
}
