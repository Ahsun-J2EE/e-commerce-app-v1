import 'package:e_commerce_app/screens/home/home_screen_view.dart';
import 'package:e_commerce_app/screens/home/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'Utils/hive_database/hive_entity.dart';

void main() async{
  //Hive Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveEntityAdapter());
  await Hive.openBox<HiveEntity>('habib_app_database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/', page: ()=> HomeScreenView(), transition: Transition.fadeIn),
        GetPage(name: HomeScreenView.routeName, page:()=> HomeScreenView(),transition: Transition.fadeIn),
        GetPage(name: ProductDetails.routeName, page:()=> ProductDetails(),transition: Transition.fadeIn),
      ],
      builder: EasyLoading.init(),
    );
  }
}
