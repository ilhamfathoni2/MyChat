import 'package:dio/dio.dart';

import '../models/contact.dart';

class ContactRepository {
  final Dio _dio = Dio();

  Future<List> fetchContacts() async {
    try {
      final response =
          await _dio.get('https://61973b0caf46280017e7e4b0.mockapi.io/MyChat');
      final data = response.data as List<dynamic>;
      final contacts = data.map((item) => Contact.fromJson(item)).toList();
      return contacts;
    } catch (error) {
      throw Exception('Failed to fetch contacts dio');
    }
  }
}
