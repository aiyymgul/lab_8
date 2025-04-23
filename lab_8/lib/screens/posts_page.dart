import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_8/models/post.dart';
import '../bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  List<Post> posts = [];
  late PostBloc postBloc;

@override
void initState() {
  postBloc = PostBloc();
  postBloc.add(GetPostEvent());
  super.initState();
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Посты (flutter_bloc)'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is FetchedPostsState) {
            if (state.posts.isEmpty) {
              return const Center(child: Text("Нет постов для отображения"));
            }
            return buildPostsList(state.posts);
          }
          // Состояние ошибки
          else if (state is FailurePostsState) {
            return Center(
              child: Text(
                "Ошибка загрузки: ${state.error}", 
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          
          else {
            // Можно показать кнопку для повторной загрузки или просто текст
            return const Center(child: Text("Нажмите для загрузки или инициализация..."));
            // Или кнопка для повторной попытки:
            // return Center(
            //   child: ElevatedButton(
            //     onPressed: () => context.read<PostBloc>().add(GetPostEvent()),
            //     child: const Text('Загрузить посты'),
            //   ),
            // );
          }
        },
      ),
    );
  }
   
   
  Widget buildPostsList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index]; 
        return Card( 
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar( 
              child: Text(post.id.toString()),
            ),
            title: Text(
              post.title, 
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding( 
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(post.body), 
            ),
            isThreeLine: true, 
          ),
        );
      },
    );
  }
}
