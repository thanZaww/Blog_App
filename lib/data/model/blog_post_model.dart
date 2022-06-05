class BlogPostModel {
  final int? id;
  final String? title, body, photo;

  BlogPostModel(
      {required this.id, required this.title, required this.body, this.photo});

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        photo: json['photo'] ?? '');
  }

  Map<String, dynamic> tojson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['photo'] = photo;
    return data;
  }
}

// class AutoGenerate {
//   AutoGenerate({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.photo,
//   });
//   late final int id;
//   late final String title;
//   late final String body;
//   late final String photo;

//   AutoGenerate.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//     photo = json['photo'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['body'] = body;
//     data['photo'] = photo;
//     return data;
//   }
// }
