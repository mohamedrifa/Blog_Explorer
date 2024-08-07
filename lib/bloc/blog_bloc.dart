import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/blog.dart';
import '../services/blog_service.dart';

// Event
abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

class ToggleLike extends BlogEvent {
  final String blogId;

  const ToggleLike(this.blogId);

  @override
  List<Object> get props => [blogId];
}

// State
abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  const BlogLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}

class BlogError extends BlogState {
  final String message;

  const BlogError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService;
  List<Blog> _blogs = [];

  BlogBloc(this.blogService) : super(BlogInitial());

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    if (event is FetchBlogs) {
      yield BlogLoading();
      try {
        _blogs = await blogService.fetchBlogs();
        yield BlogLoaded(_blogs);
      } catch (e) {
        yield BlogError(e.toString());
      }
    } else if (event is ToggleLike) {
      final blogId = event.blogId;
      final blog = _blogs.firstWhere((blog) => blog.id == blogId);
      blog.liked = !blog.liked;
      yield BlogLoaded(List.from(_blogs)); 
    }
  }
}
