import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/main.dart';
import 'package:blog_explorer/screens/blog_list_screen.dart';
import 'package:blog_explorer/screens/blog_details_screen.dart';
import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:blog_explorer/services/blog_service.dart';
import 'package:blog_explorer/models/blog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Blog Explorer App', () {
    late MockClient client;
    late BlogService blogService;

    setUp(() {
      client = MockClient();
      blogService = BlogService(client: client);
    });

    testWidgets('loads and displays blogs', (WidgetTester tester) async {
      
      when(client.get(
        Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
        jsonEncode([
          {
            'id': '1',
            'title': 'Blog Title 1',
            'content': 'Content of Blog 1',
            'image_url': 'https://example.com/image1.jpg'
          },
          {
            'id': '2',
            'title': 'Blog Title 2',
            'content': 'Content of Blog 2',
            'image_url': 'https://example.com/image2.jpg'
          },
        ]),
        200,
      ));

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => BlogBloc(blogService)..add(FetchBlogs()),
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => BlogListScreen(),
              '/details': (context) => BlogDetailsScreen(),
            },
          ),
        ),
      );

      
      await tester.pumpAndSettle();
      expect(find.text('Blog Title 1'), findsOneWidget);
      expect(find.text('Blog Title 2'), findsOneWidget);

      
      await tester.tap(find.text('Blog Title 1'));
      await tester.pumpAndSettle();

      
      expect(find.text('Blog Title 1'), findsOneWidget);
      expect(find.text('Content of Blog 1'), findsOneWidget);
    });
  });
}
