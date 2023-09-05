import 'package:flutter/material.dart';
import 'package:learn_flutter/main.dart';
import 'package:learn_flutter/src/services/messages/delete.dart';

class MessageUtils {
  static void deleteMessage(
    BuildContext context,
    String messageId,
  ) {
    final deleteMsgRepository = DeleteMessageRepository();
    deleteMsgRepository.deleteMessage(messageId).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pesan berhasil dihapus.'),
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
            content: Text('Gagal menghapus pesan.'),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus pesan: $error'),
        ),
      );
    });
  }
}
