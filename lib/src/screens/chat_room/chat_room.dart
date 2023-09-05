import 'package:flutter/material.dart';
import 'package:learn_flutter/src/controller/messages/delete_message.dart';
import 'package:learn_flutter/src/controller/messages/edit_message.dart';
import 'package:learn_flutter/src/services/contacts/contact_service.dart';

import '/src/models/message.dart';
import '/src/shared/theme.dart';

class ChatRoomScreen extends StatefulWidget {
  final String id;

  const ChatRoomScreen({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late Future<Message?> _messageFuture;

  @override
  void initState() {
    super.initState();
    _messageFuture = ContactRepository().fetchMessageById(widget.id);
  }

  final List<Color> senderColors = [
    kPrimaryColor,
    kBlueColor,
    kOrangeColor,
    kSoftRedColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room',
            style: lightTextStyle.copyWith(fontWeight: semiBold)),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<Message?>(
        future: _messageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final message = snapshot.data;
            if (message == null) {
              return const Center(child: Text('No message available.'));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        Color senderColor =
                            senderColors[index % senderColors.length];
                        return ChatBubble(
                          sender: message.name,
                          time: message.time,
                          text: message.shortMessage,
                          senderColor: senderColor,
                          messageId: message.id,
                        );
                      },
                    ),
                  ),
                  const InputField(),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String sender;
  final String time;
  final String text;
  final Color senderColor;
  final String messageId;

  const ChatBubble({
    Key? key,
    required this.sender,
    required this.time,
    required this.text,
    required this.senderColor,
    required this.messageId,
  }) : super(key: key);

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
            PopupMenuButton(
              color: kWhiteColor,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "edit",
                  child: Text("Edit"),
                ),
                const PopupMenuItem(
                  value: "delete",
                  child: Text("Delete"),
                ),
              ],
              onSelected: (value) {
                if (value == "edit") {
                  // Membuka dialog pesan
                  showDialog(
                    context: context,
                    builder: (context) {
                      String editedText = text;
                      return AlertDialog(
                        title: const Text("Edit Message"),
                        content: TextField(
                          onChanged: (value) {
                            editedText = value;
                          },
                          controller: TextEditingController(text: text),
                          decoration: const InputDecoration(
                            hintText: "Edit your message...",
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              UpdateMessageController.updateMessages(
                                  context, messageId, editedText);
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      );
                    },
                  );
                } else if (value == "delete") {
                  DeleteMessageController.deleteMessage(context, messageId);
                }
              },
            ),
            Text(sender,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kWhiteColor)),
            Text(time.substring(11, 16),
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
  const InputField({Key? key}) : super(key: key);

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