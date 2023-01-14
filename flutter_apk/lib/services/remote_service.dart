import 'package:flutter_apk/model/postphoto_model.dart';
import 'package:flutter_apk/model/postproduct_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<PostProductModel>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
    throw Exception('Failed to load post');
  }

  Future<List<PostPhoto?>?> getPhoto() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postPhotoFromJson(json);
    }
    throw Exception('Failed to load post');
  }
}
