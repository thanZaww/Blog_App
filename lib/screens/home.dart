import 'package:flutter/material.dart';
import 'package:flutter_rest_api_blog/controller/post_list_controller.dart';
import 'package:flutter_rest_api_blog/data/model/post_list_model.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../widget/post_list_widget.dart';
import '/custom_extension/custom_extension.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final PostListController _postListController = Get.put(PostListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts').center,
      ),
      body: Obx(
        () {
          PostListState state = _postListController.postListstate.value;
          if (state is PostListLoading) {
            return ListView(
              children: [
                for (int i = 0; i < 15; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white10,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      height: 30,
                      color: Colors.grey,
                    ),
                  ),
              ],
            );
          } else if (state is PostListSuccess) {
            List<PostListModel> posts = state.postLists;
            return PostListWidget(posts: posts);
          } else if (state is PostListError) {
            return const Text('Error').scaleEvenly(1.5).center;
          }
          return const Center();
        },
      ),
    );
  }
}
//   FutureBuilder<List<PostListModel>> newMethod() {
//     return FutureBuilder<List<PostListModel>>(
//         future: postApiService.getAllPost(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return PostListWidget(posts: snapshot.data ?? []);
//           } else if (snapshot.hasError) {
//             return const Text('Error').center;
//           }
//           return const CircularProgressIndicator().center;
//         });
//   }
// }
