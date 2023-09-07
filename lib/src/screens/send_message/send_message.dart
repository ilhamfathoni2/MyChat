import 'package:flutter/material.dart';
import 'package:learn_flutter/main.dart';
import 'package:learn_flutter/src/models/send_message.dart';
import 'package:learn_flutter/src/services/messages/send_message.dart';
import 'package:learn_flutter/src/shared/theme.dart';
import 'package:intl/intl.dart';

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  bool isSending = false; // Menyimpan status pengiriman

  Future<void> sendMessage(String shortMessage) async {
    final messageService = MessageRepository();
    final message = MessageToSend(
      time: getCurrentTime(),
      name: 'Tommy',
      shortMessage: shortMessage,
      image: 'assets/img/profilem2.png',
    );

    setState(() {
      isSending = true; // Aktifkan efek loading
    });

    await messageService.sendMessage(message);

    setState(() {
      isSending = false;
    });

    // Navigasi setelah send
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MyApp();
          },
        ),
      );
    });
  }

  String getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return formatter.format(now.toUtc());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const MyApp();
                },
              ),
            );
          },
        ),
        title: Center(
          child: Text(
            'Send Message',
            style: lightTextStyle.copyWith(fontWeight: semiBold),
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Nama Pengirim',
                        style: lightTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'ini isi pesan',
                        style: lightTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: reguler,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSending
                  ? null // Tombol disable ketika pengiriman
                  : () {
                      sendMessage(messageController.text);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Send',
                    style: lightTextStyle.copyWith(
                        fontSize: 16, fontWeight: medium),
                  ),
                  SizedBox(width: isSending ? 8 : 0),
                  if (isSending)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
