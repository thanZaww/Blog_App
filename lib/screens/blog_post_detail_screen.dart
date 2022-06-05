import 'package:flutter_rest_api_blog/data/api_service/post_api_service.dart';
import 'package:flutter_rest_api_blog/data/model/blog_post_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/blog_post_controller.dart';

class BlogPostDetailScreen extends StatefulWidget {
  const BlogPostDetailScreen({Key? key, required this.id, required this.title})
      : super(key: key);
  final int id;
  final String title;

  @override
  State<BlogPostDetailScreen> createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {
  final BlogPostController _blogPostController = Get.put(BlogPostController());

  @override
  void initState() {
    super.initState();
    _blogPostController.getPost(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Obx(
        () {
          final BlogPostState blogPostState =
              _blogPostController.blogPostState.value;
          if (blogPostState is BlogPostSuccess) {
            BlogPostModel post = blogPostState.post;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(post.title ?? ''),
                    ),
                  ),
                  const Divider(thickness: 1),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(post.body ?? ''),
                    ),
                  ),
                  const Divider(thickness: 1),
                  (post.photo == null || post.photo!.isEmpty)
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image.network(
                            '${PostApiService.baseUrl}/${post.photo}',
                          ),
                        ),
                ],
              ),
            );
          }
          if (blogPostState is BlogPostError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (blogPostState is BlogPostLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade400.withOpacity(0.5),
              highlightColor: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
