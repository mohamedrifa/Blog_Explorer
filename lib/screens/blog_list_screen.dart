import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog_bloc.dart';
import '../models/blog.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Explorer',
          style: TextStyle(
            fontFamily: 'CustomFont', 
            fontSize: 24.0, 
            fontWeight: FontWeight.bold, 
            color: Colors.white, 
          ),
        ),
        backgroundColor: Colors.blue, 
        centerTitle: true, 
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), 
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: blog,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                blog.imageUrl,
                                width: double.infinity, 
                                height: 200.0, 
                                fit: BoxFit.cover, 
                              ),
                            ),
                            Positioned(
                              top: 10.0,
                              right: 10.0,
                              child: IconButton(
                                icon: Icon(
                                  blog.liked ? Icons.favorite : Icons.favorite_border,
                                  color: blog.liked ? Colors.red : Colors.white,
                                ),
                                onPressed: () {
                                  context.read<BlogBloc>().add(ToggleLike(blog.id));
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          blog.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is BlogError) {
            return Center(
              child: Text(
                'Failed to load blogs',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
