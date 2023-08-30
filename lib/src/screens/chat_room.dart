import 'package:flutter/material.dart';

import '/src/models/message.dart';
import '/src/shared/theme.dart';

class ChatRoomScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(sender: 'Acel', time: '2:30 PM', text: 'Hello, how are you?'),
    Message(
        sender: 'Jennie Blackpink',
        time: '2:32 PM',
        text: 'I\'m good, thanks!'),
    Message(sender: 'Aslam', time: '2:34 PM', text: 'Iyaak'),
    Message(sender: 'Acel', time: '2:40 PM', text: 'Please use English'),
    Message(
        sender: 'Jennie Blackpink',
        time: '2:32 PM',
        text: 'What are you talking about'),
  ];

  // List warna untuk sender
  final List<Color> senderColors = [
    kPrimaryColor,
    kBlueColor,
    kOrangeColor,
    kSoftRedColor,
    // Tambahkan warna lainnya sesuai kebutuhan
  ];

  ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor, title: const Text('Chat Room')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                Color senderColor = senderColors[index % senderColors.length];
                return ChatBubble(
                  sender: message.sender,
                  time: message.time,
                  text: message.text,
                  senderColor: senderColor,
                );
              },
            ),
          ),
          const InputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String sender;
  final String time;
  final String text;
  final Color senderColor;

  const ChatBubble({
    super.key,
    required this.sender,
    required this.time,
    required this.text,
    required this.senderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: senderColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(sender,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor)),
            Text(time,
                style:
                    lightTextStyle.copyWith(fontSize: 10, fontWeight: light)),
            Text(text, style: TextStyle(color: kWhiteColor)),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
