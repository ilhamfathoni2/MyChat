class Contact {
  final String name;
  final String shortMessage;
  final String time;
  final String image;
  final String id;

  Contact({
    required this.name,
    required this.shortMessage,
    required this.time,
    required this.image,
    required this.id,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      time: json['time'] as String,
      name: json['name'] as String,
      shortMessage: json['shortMessage'] as String,
      image: json['image'] as String,
      id: json['id'] as String,
    );
  }
}
