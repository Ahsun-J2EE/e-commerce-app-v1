
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen_controller.dart';

class ProductDetails extends StatelessWidget {
static const String routeName='/product_details';
final HomeScreenController _controller= Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    var name= _controller.productDataList.value[_controller.selectedItemIndex.value].name;
    print('Received Item:$name');
    return  Scaffold(
      appBar: AppBar(
        title: Text(name.toString()),
      ),
    );
  }
}
