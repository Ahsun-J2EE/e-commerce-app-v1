
import 'package:badges/badges.dart';
import 'package:e_commerce_app/Utils/api.dart';
import 'package:e_commerce_app/screens/home/home_screen_controller.dart';
import 'package:e_commerce_app/screens/home/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../Utils/hive_database/hive_entity.dart';

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
        actions: [
          // IconButton(
          //     onPressed: (){},
          //     icon: const Icon(Icons.search)
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 5),
            child: Badge(
              badgeContent: Obx(()=>Text(Get.put(HomeScreenController()).localDataList.length.toString())),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
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
              margin: const EdgeInsets.only(right: 10, left: 10),
              color: Colors.white,
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Padding(padding: const EdgeInsets.only(left: 10),
                   child: Text(_controller.productDataList.value[_controller.selectedItemIndex.value].price.toString()??'0'),

                  ),

                  Padding(padding: const EdgeInsets.only(right: 10),
                   child: IconButton(
                    onPressed: () {
                      Get.put(HomeScreenController()).insertShoppingCartData( HiveEntity(
                          name: '${_controller.productDataList.value[_controller.selectedItemIndex.value].name}',
                          price: '\$${_controller.productDataList.value[_controller.selectedItemIndex.value].price}',
                          id: '${_controller.productDataList.value[_controller.selectedItemIndex.value].id}',
                          image: API.productImageUrl+_controller.productDataList.value[_controller.selectedItemIndex.value].image![0].toString(),
                          quantity: 1));
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),),
                  )
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
