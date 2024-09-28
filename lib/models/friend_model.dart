class FriendModel {
  final String name;
  final String description;
  final String imgUrl;
  final String uid;

  FriendModel({
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.uid,
  });

  factory FriendModel.fromJson(Map<String, dynamic> doc){
    return FriendModel(name: doc['name'], description: doc['des'], imgUrl: doc['imgUrl'], uid: doc['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "des": description,
      "imgUrl": imgUrl,
      "uid": uid,
    };
  }

}
