class UploadResponseModel {
  final String? result;

  UploadResponseModel(this.result);

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadResponseModel(
      json['result'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result;
    return data;
  }
}
