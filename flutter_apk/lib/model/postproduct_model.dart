
import 'dart:convert';

List<PostProductModel> postFromJson(String str) => List<PostProductModel>.from(
    json.decode(str).map((x) => PostProductModel.fromJson(x)));

String postToJson(List<PostProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostProductModel {
  PostProductModel({
    required this.userId,
    required this.id,
    required this.title,
    this.body,
  });

  int userId;
  int id;
  String title;
  String? body;

  factory PostProductModel.fromJson(Map<String, dynamic> json) =>
      PostProductModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
