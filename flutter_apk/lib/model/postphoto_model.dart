// To parse this JSON data, do
//
//     final postPhoto = postPhotoFromJson(jsonString);

import 'dart:convert';

List<PostPhoto?>? postPhotoFromJson(String str) => json.decode(str) == null ? [] : List<PostPhoto?>.from(json.decode(str)!.map((x) => PostPhoto.fromJson(x)));

String postPhotoToJson(List<PostPhoto?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class PostPhoto {
    PostPhoto({
        this.albumId,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
    });

    int? albumId;
    int? id;
    String? title;
    String? url;
    String? thumbnailUrl;

    factory PostPhoto.fromJson(Map<String, dynamic> json) => PostPhoto(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
    );

    Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
    };
}
