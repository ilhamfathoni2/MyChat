import 'package:flutter/material.dart';
import 'package:learn_flutter/main.dart';
import 'package:learn_flutter/src/services/messages/edit.dart';

class UpdateMessageController {
  static void updateMessages(
      BuildContext context, String messageId, String shortMessage) {
    final updateMessage = UpdateMessageService();
    updateMessage.updateMessage(messageId, shortMessage).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pesan berhasil update.'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal update pesan.'),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal update pesan: $error'),
        ),
      );
    });
  }
}
