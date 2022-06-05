import 'package:get/get.dart';

import '../data/api_service/post_api_service.dart';
import '../data/model/blog_post_model.dart';

class BlogPostController extends GetxController {
  final PostApiService _postApiService = Get.find();
  Rx<BlogPostState> blogPostState = BlogPostState().obs;
  void getPost(int id) {
    blogPostState.value = BlogPostLoading();
    _postApiService.getPost(id).then(
      (post) {
        if (post.isNotEmpty) {
          blogPostState.value = BlogPostSuccess(post[0]);
        }
      },
    ).catchError((e) {
      blogPostState.value = BlogPostError();
    });
  }
}

class BlogPostState {}

class BlogPostLoading extends BlogPostState {}

class BlogPostSuccess extends BlogPostState {
  final BlogPostModel post;
  // final List<BlogPostModel> post; ဒီလိုသုံးရင် index မလို။

  BlogPostSuccess(this.post);
}

class BlogPostError extends BlogPostState {}
