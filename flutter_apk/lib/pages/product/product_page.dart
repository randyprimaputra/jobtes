import 'package:flutter/material.dart';
import 'package:flutter_apk/model/postphoto_model.dart';
//import 'package:flutter_apk/model/postproduct_model.dart';
import 'package:flutter_apk/pages/login_page.dart';
import 'package:flutter_apk/services/remote_service.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<PostPhoto>? postphoto;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getDataProduct();
  }

  getDataProduct() async {
    postphoto = (await RemoteService().getPhoto())?.cast<PostPhoto>();
    if (postphoto != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return const LoginPage();
              }));
            },
          )
        ],
      ),
      body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: postphoto?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange[300],
                      ),
                      child: Center(
                          child: Image.network(
                        postphoto![index].thumbnailUrl ?? '',
                        fit: BoxFit.cover,
                      )),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postphoto![index].title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           Text(
                             postphoto![index].title ?? '',
                             maxLines: 3,
                             overflow: TextOverflow.ellipsis,
                           ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          replacement: const Center(child: CircularProgressIndicator())),
    );
  }
}
