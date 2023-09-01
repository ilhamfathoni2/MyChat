import 'package:dio/dio.dart';
import 'package:learn_flutter/src/models/send_message.dart';

class MessageRepository {
  final Dio _dio = Dio();
  final String _api = 'https://61973b0caf46280017e7e4b0.mockapi.io';

  Future<void> sendMessage(MessageToSend message) async {
    try {
      final response = await _dio.post(
        '$_api/MyChat', // Ganti dengan URL API yang sesuai
        data: message.toJson(),
      );
      if (response.statusCode == 200) {
        // Pengiriman pesan berhasil
      } else {
        // Penanganan kesalahan
      }
    } catch (error) {
      // Penanganan kesalahan jika terjadi kesalahan jaringan dll
    }
  }
}
