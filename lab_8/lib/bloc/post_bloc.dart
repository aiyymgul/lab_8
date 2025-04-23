import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/post.dart';
import '../repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _repository = PostRepository();

  PostBloc() : super(PostInitial()) {
    on<GetPostEvent>(_onGetPosts); 
  }

  Future<void> _onGetPosts(GetPostEvent event, Emitter<PostState> emit) async {
    emit(LoadingPostState()); 
    try {
      final List<Post> posts = await _repository.getPosts();
      emit(FetchedPostsState(posts));
    } catch (e) {
      emit(FailurePostsState(error: e.toString()));
    }
  }
}

