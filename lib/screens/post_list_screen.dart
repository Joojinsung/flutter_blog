import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/widgets/post_widget.dart';
import 'package:http/http.dart' as http;

import '../../models/PostModel.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<PostModel> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse('http://192.168.0.4:8080/post/getPosts'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          posts = jsonList.map((json) => PostModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load posts'); // 에러 발생 시 예외 처리
      }
    } catch (e) {
      // 에러 처리
      print('Error fetching posts: $e'); // 에러 메시지 출력 등 추가적인 처리 가능
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 목록'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchPosts,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostWidget(post: posts[index]);
                },
              ),
            ),
    );
  }
}
