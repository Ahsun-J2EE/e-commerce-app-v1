import 'package:dio/dio.dart';
import 'package:e_commerce_app/Utils/api.dart';
import 'package:e_commerce_app/Utils/hive_database/hive_entity.dart';
import 'package:e_commerce_app/screens/model/Products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController tabController;
  var scrollbarController= ScrollController();
  var productDataList=<Products>[].obs;
  var localDataList=<HiveEntity>[].obs;
  //RxObjectMixin <CategoryModel> categoryData= CategoryModel().obs;

  @override
  void onInit() {
    tabController=TabController(length: 4, vsync: this);
    _categoryData();
    getLocalData();
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

  void getLocalData() async{
    var box= await Hive.openBox<HiveEntity>('habib_app_database');
    localDataList.value=box.values.toList();
    print('localData list length ${localDataList.length}');
  }

  void insertShoppingCartData(HiveEntity entity) async{
    var box= await Hive.openBox<HiveEntity>('habib_app_database');
    box.add(entity);
    getLocalData();
  }

  void deleteShoppingCartData(int index) async{
    var box= await Hive.openBox<HiveEntity>('habib_app_database');
    box.deleteAt(index);
    getLocalData();
  }

  void updateShoppingCartData(int index, HiveEntity entity) async{
    var box= await Hive.openBox<HiveEntity>('habib_app_database');
    box.putAt(index, entity);
    getLocalData();
  }

  void clearAllShoppingCartData(int index, HiveEntity entity) async{
    var box= await Hive.openBox<HiveEntity>('habib_app_database');
    await box.clear();
    getLocalData();
  }
  String calculateItemTotalPrice(String price, int quantity) {

    return '';
  }
// var sharedUsername=''.obs;
// var sharedEmail=''.obs;
// var sharedPhone=''.obs;
// var sharedImage=''.obs;
//
//   @override
//   void onInit() {
//     getSharedPrefData();
//     super.onInit();
//   }
//
//   void getSharedPrefData() async{
//     SharedPreferences peon= await SharedPreferences.getInstance();
//     try{
//       // prefs.setString('User-Name:', userName);
//       // prefs.setString('User-Email:', email);
//       // prefs.setString('User-Mobile:', mobile);
//       // prefs.setString('User-Image:', image);
//
//       sharedUsername.value=peon.getString('USER-NAME')!;
//       sharedEmail.value=peon.getString('USER-EMAIL')!;
//       sharedPhone.value=peon.getString('USER-MOBILE')!;
//       sharedImage.value=peon.getString('USER-IMAGE')!;
//
//     }catch(e, l){
//       print(e);
//       print(l);
//       print('Shared Username: $sharedUsername');
//     }
//   }
//
//   void logOut() async{
//     //logOUt process can be done in two ways
//     //One is clear shared preferences data and navigate to login page
//     //Another one is log out by server by calling the logout api
//     SharedPreferences peon= await SharedPreferences.getInstance();
//     peon.clear();
//     //Get.offAll(LoginScreenView());
// }
}