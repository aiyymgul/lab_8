import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_8/bloc/post_bloc.dart';
import 'package:lab_8/screens/posts_page.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(GetPostEvent()),
      child: MaterialApp(
        title: 'Posts App (BLoC)', 
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true, 
        ),
        home: const PostPage(), 
      ),
    );
  }
}
