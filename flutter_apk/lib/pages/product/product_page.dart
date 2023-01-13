import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';
import 'package:flutter_apk/model/postProduct_model.dart';
import 'package:flutter_apk/services/remote_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List<PostProductModel>? postsProduct;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getDataProduct();
  }

  getDataProduct () async {
    postsProduct = await RemoteService().getDataProduct();
    if(postsProduct != null)
    {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const MyAppBar(title: 'Product'),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: postsProduct?.length,
          itemBuilder: ((context, index) {
          return Container(
            child: Text(postsProduct![index].products),
          );
        })),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ) ,
      )
    );
  }
}