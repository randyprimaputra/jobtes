import '../model/postproduct_model.dart';
import 'package:http/http.dart' as http;

class RemoteService
{
  Future<List<PostProductModel>> getDataProduct() async{
    var client = http.Client();

    var uri = Uri.parse('https://dummyjson.com/products');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
    return null;
  }
 }