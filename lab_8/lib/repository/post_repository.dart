// repository/post_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

 Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        
        final List<Post> posts = jsonList.map((json) => Post.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to load posts (Status code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
