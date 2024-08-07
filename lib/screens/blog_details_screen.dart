import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog_bloc.dart';
import '../models/blog.dart';

class BlogDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Blog blog = ModalRoute.of(context)!.settings.arguments as Blog;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: TextStyle(
            fontSize: 24.0, 
            fontWeight: FontWeight.bold, 
            color: Colors.white, 
          ),
        ),
        backgroundColor: Colors.blue, 
        elevation: 0, 
        centerTitle: true, 
        actions: [
          IconButton(
            icon: Icon(
              blog.liked ? Icons.favorite : Icons.favorite_border,
              color: blog.liked ? Colors.red : Colors.white,
            ),
            onPressed: () {
              context.read<BlogBloc>().add(ToggleLike(blog.id));
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0), 
              child: Image.network(
                blog.imageUrl,
                width: double.infinity, 
                height: 250.0,
                fit: BoxFit.cover, 
              ),
            ),
            SizedBox(height: 16),
            Text(
              blog.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              blog.content,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
