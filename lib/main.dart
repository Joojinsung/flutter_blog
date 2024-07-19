import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/create_post_page.dart';
import 'package:flutter_blog/screens/post_list_screen.dart';
import 'package:flutter_blog/screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Signup(),
    );
  }
}
