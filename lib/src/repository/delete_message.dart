import 'package:dio/dio.dart';

class DeleteMessageRepository {
  final Dio _dio = Dio();
  final String _api = 'https://61973b0caf46280017e7e4b0.mockapi.io';

  Future<bool> deleteMessage(String id) async {
    try {
      final response = await _dio.delete('$_api/MyChat/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Failed to fetch message by ID');
    }
  }
}
