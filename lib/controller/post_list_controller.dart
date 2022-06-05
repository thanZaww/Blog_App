import 'package:flutter_rest_api_blog/data/api_service/post_api_service.dart';
import 'package:flutter_rest_api_blog/data/model/post_list_model.dart';
import 'package:get/get.dart';

class PostListController extends GetxController {
  final PostApiService _postApiService = Get.find();
  Rx<PostListState> postListstate = PostListState().obs;
  @override
  void onInit() {
    super.onInit();
    getAllPost();
  }

  void getAllPost() {
    postListstate.value = PostListLoading();
    _postApiService.getAllPost().then(
      (postLists) {
        postListstate.value = PostListSuccess(postLists);
      },
    ).catchError((e) {
      postListstate.value = PostListError();
    });
  }
}

class PostListState {}

class PostListLoading extends PostListState {}

class PostListError extends PostListState {}

class PostListSuccess extends PostListState {
  final List<PostListModel> postLists;

  PostListSuccess(this.postLists);
}
