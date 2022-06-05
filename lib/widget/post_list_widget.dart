import 'package:flutter/material.dart';
import 'package:flutter_rest_api_blog/screens/blog_post_detail_screen.dart';
import 'package:get/get.dart';
import '/custom_extension/custom_extension.dart';
import '/data/model/post_list_model.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.posts}) : super(key: key);
  final List<PostListModel> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 8, top: 10, right: 8, bottom: 30),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(BlogPostDetailScreen(
                id: posts[index].id ?? 0, title: posts[index].title ?? ''));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(posts[index].title ?? '').center,
            ),
          ),
        );
      },
    );
  }
}
