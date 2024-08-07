import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/blog_list_screen.dart';
import 'screens/blog_details_screen.dart';
import 'bloc/blog_bloc.dart';
import 'services/blog_service.dart';

void main() {
  final BlogService blogService = BlogService();

  runApp(
    BlocProvider(
      create: (context) => BlogBloc(blogService)..add(FetchBlogs()),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => BlogListScreen(),
          '/details': (context) => BlogDetailsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
