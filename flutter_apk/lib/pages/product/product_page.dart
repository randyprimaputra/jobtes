import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';
import 'package:flutter_apk/model/postproduct_model.dart';
import 'package:flutter_apk/services/remote_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  PostProductModel? postProduct;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getDataProduct().then((data){
      setState((){
        postProduct = data;
        isLoaded = true;
      });
    });
  }

  Future<List<PostProductModel>> getDataProduct () async {
    var postProduct = await RemoteService().getDataProduct();
    if(postProduct != null)
    {
      return [postProduct];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const MyAppBar(title: 'Product'),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: postProduct?.products?.length,
          itemBuilder: ((context, index) {
          return Text(postProduct!.products![index]!.title.toString());
          
        })),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ) ,
      )
    );
  }
}