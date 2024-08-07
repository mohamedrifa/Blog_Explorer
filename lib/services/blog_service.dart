import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog.dart';

class BlogService {
  final http.Client client;
  static const String _url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  static const String _adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  BlogService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await client.get(Uri.parse(_url), headers: {
        'x-hasura-admin-secret': _adminSecret,
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['blogs'];
        return data.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load blogs: $e');
    }
  }
}
