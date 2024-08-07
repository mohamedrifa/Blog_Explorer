import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  bool liked;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.liked = false,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] ?? '', 
      imageUrl: json['image_url'] as String,
      liked: json['liked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'liked': liked,
    };
  }

  @override
  List<Object> get props => [id, title, content, imageUrl, liked];
}
