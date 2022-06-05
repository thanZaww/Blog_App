class PostListModel {
  final int? id;
  final String? title;
  PostListModel({this.id, this.title});

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
      );
}
