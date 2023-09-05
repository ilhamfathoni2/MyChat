import 'package:dio/dio.dart';
import 'package:learn_flutter/src/models/contact.dart';
import 'package:learn_flutter/src/models/message.dart';

class ContactRepository {
  final Dio _dio = Dio();
  final String _api = 'https://61973b0caf46280017e7e4b0.mockapi.io';

  Future<List> fetchContacts() async {
    try {
      final response = await _dio.get('$_api/MyChat');
      final data = response.data as List<dynamic>;
      final contacts = data.map((item) => Contact.fromJson(item)).toList();
      return contacts;
    } catch (error) {
      throw Exception('Failed to fetch contacts dio');
    }
  }

  Future<Message?> fetchMessageById(String id) async {
    try {
      final response = await _dio.get('$_api/MyChat/$id');
      final data = response.data as Map<String, dynamic>;
      if (data.isNotEmpty) {
        final message = Message.fromJson(data);
        return message;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception('Failed to fetch message by ID');
    }
  }
}
