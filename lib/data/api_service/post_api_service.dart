import 'package:dio/dio.dart' as d;
import '/data/model/upload_response_model.dart';
import '../model/blog_post_model.dart';
import '../model/post_list_model.dart';

class PostApiService {
  static const baseUrl = 'https://rubylearner.herokuapp.com';
  final d.Dio _dio = d.Dio();

  Future<List<PostListModel>> getAllPost() async {
    var result = await _dio.get('$baseUrl/posts');
    final postList = result.data as List;
    return postList.map(
      (post) {
        return PostListModel.fromJson(post);
      },
    ).toList();
  }

  Future<List<BlogPostModel>> getPost(int id) async {
    final result = await _dio.get('$baseUrl/post?id=$id');
    final postList = result.data as List;
    return postList.map(
      (post) {
        return BlogPostModel.fromJson(post);
      },
    ).toList();
  }

  Future<UploadResponseModel> uploadPost(
      {required String title,
      required String body,
      required d.FormData? photo}) async {
    final result =
        await _dio.post('$baseUrl/post?title=$title&body=$body', data: photo);
    final uploadResponse = UploadResponseModel.fromJson(result.data);
    return uploadResponse;
  }
}
