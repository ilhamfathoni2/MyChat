class MessageToSend {
  final String time;
  final String name;
  final String shortMessage;
  final String image;

  MessageToSend({
    required this.time,
    required this.name,
    required this.shortMessage,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "name": name,
      "shortMessage": shortMessage,
      "image": image,
    };
  }
}
