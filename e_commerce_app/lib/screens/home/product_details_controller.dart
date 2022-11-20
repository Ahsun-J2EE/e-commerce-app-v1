
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../Utils/api.dart';
import '../model/Products.dart';

class ProductDetailsController extends GetxController{

  var selectedItemIndex=0.obs;
  var productDataList= <Products>[].obs;


  @override
  void onInit() {
    _categoryData();
    super.onInit();
  }
  void _categoryData() async{
    Dio dio= Dio();

    try{
      var response= await dio.get(API.getProductDataEndPoint);
      if(response.statusCode==200){
        var myResponse=response.data as Map;
        var productList= response.data["products"] as List;
        var imagepath=response.data["products"][0]["image"][0];
        print('IMage path:$imagepath');
        print('Status Code:${response.statusCode}');
        var myProductList= productList.map((e) => Products.fromJson(e));
        productDataList.addAll(myProductList);
        print('Product Data length: ${myProductList.length}');
      }else{

      }
    }catch(e,l){
      print(e);
      print(l);
    }
  }
}