class MessageModel {
  final String msg;
  final DateTime timestamp;
  final String chatId;
  final String senderId;

  MessageModel(
      {required this.msg, required this.timestamp, required this.chatId, required this.senderId});

  Map<String, dynamic> toJson() {
    return {
      "msg": msg,
      "timestamp": timestamp,
      "chatId": chatId,
      "senderId": senderId,
    };
  }
}
