
import 'package:e_commerce_app/Utils/api.dart';
import 'package:e_commerce_app/screens/home/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
static const String routeName='/product_details';
final ProductDetailsController _controller= Get.put(ProductDetailsController());

   ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: Obx(()=>Text(_controller.productDataList.value[_controller.selectedItemIndex.value].name!)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              height: 200,
              width: double.infinity,
              child: Obx(()=>Image.network(API.productImageUrl+_controller.productDataList.value[_controller.selectedItemIndex.value].image![0].toString())),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              color: Colors.white,
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Padding(padding: EdgeInsets.only(left: 10),
                   child: Text(_controller.productDataList.value[_controller.selectedItemIndex.value].price.toString()??'0'),
                  ),

                  Padding(padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.shopping_cart)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              color: Colors.white,
              height: 200,
              width: double.infinity,
              child: Obx(()=>Html(data: _controller.productDataList.value[_controller.selectedItemIndex.value].description,)) ,
            ),
          ],
        ),
      ),
    );
  }
}
