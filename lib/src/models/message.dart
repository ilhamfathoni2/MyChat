class Message {
  final String time;
  final String name;
  final String shortMessage;
  final String image;
  final String id;

  Message({
    required this.time,
    required this.name,
    required this.shortMessage,
    required this.image,
    required this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      time: json['time'] as String,
      name: json['name'] as String,
      shortMessage: json['shortMessage'] as String,
      image: json['image'] as String,
      id: json['id'] as String,
    );
  }
}
