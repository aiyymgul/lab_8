part of 'post_bloc.dart';

sealed class PostState extends Equatable {
   const PostState();
   @override
  List<Object> get props => [];
  }

final class PostInitial extends PostState {}

final class LoadingPostState extends PostState {}

final class FetchedPostsState extends PostState {
  final List<Post> posts; 
  const FetchedPostsState(this.posts);

  @override
  List<Object> get props => [posts]; 
}

final class FailurePostsState extends PostState {
  final String error; 
  const FailurePostsState({this.error = "Произошла ошибка"});

   @override
  List<Object> get props => [error];
}
