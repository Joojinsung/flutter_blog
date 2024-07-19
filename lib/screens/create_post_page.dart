import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/post_list_screen.dart';
import 'package:flutter_blog/screens/signup.dart';
import 'package:flutter_blog/screens/widgets/login_logout_button.dart';
import 'package:http/http.dart' as http;

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool isLoggedIn = true;

  void _handleLogout() {
    setState(() {
      isLoggedIn = false;
    });
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
  }

  Future<void> _submitPost() async {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isEmpty || content.isEmpty) {
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.0.4:8080/post/store'),
      headers: {'X-Requested-With': 'Flutter'},
      body: {
        'title': title,
        'content': content,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post created successfully')),
      );

      await Future.delayed(Duration(milliseconds: 500));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostListScreen(),
        ),
      );

      _titleController.clear();
      _contentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        actions: [
          LoginLogoutButton(
            isLogin: isLoggedIn,
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitPost();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
