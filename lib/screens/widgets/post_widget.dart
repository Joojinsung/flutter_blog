import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/PostModel.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${post.id}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              post.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('작성자: ${post.userId}'),
                const Spacer(),
                Text(
                  '작성일: ${DateFormat('yyyy-MM-dd HH:mm').format(post.regDate)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
