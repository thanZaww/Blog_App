import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_blog/widget/bottom_nav.dart';

import '/controller/post_list_controller.dart';
import '/data/api_service/post_api_service.dart';
import '/data/model/upload_response_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class UploadController extends GetxController {
  final PostApiService _postApiService = Get.find();
  final PostListController _postListController = Get.find();
  Rx<UploadState> uploadState = UploadState().obs;

  void uploadPost(String title, String body, dio.FormData? photo) {
    uploadState.value = UploadLoading();
    _postApiService.uploadPost(title: title, body: body, photo: photo).then(
      (uploadResponse) {
        uploadState.value = UploadSuccess(uploadResponse);
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.off(const BottomNav());
          _postListController.getAllPost();
          uploadState.value = UploadState();
        });
      },
    ).catchError(
      (e) {
        uploadState.value = UploadError();
      },
    ).whenComplete(() => const Text('Complete'));
  }
}

class UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final UploadResponseModel uploadResponse;

  UploadSuccess(this.uploadResponse);
}

class UploadError extends UploadState {}
