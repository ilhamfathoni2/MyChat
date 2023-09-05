import 'package:dio/dio.dart';

class UpdateMessageService {
  final Dio _dio = Dio();
  final String _api = 'https://61973b0caf46280017e7e4b0.mockapi.io';

  Future<bool> updateMessage(String id, String shortMessage) async {
    try {
      final response = await _dio.put(
        '$_api/MyChat/$id',
        data: {
          "shortMessage": shortMessage,
        },
      );
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
