import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/Utils/api.dart';
import 'package:e_commerce_app/Utils/hive_database/hive_entity.dart';
import 'package:e_commerce_app/screens/category/product_view.dart';
import 'package:e_commerce_app/screens/home/home_screen_controller.dart';
import 'package:e_commerce_app/screens/home/product_details.dart';
import 'package:e_commerce_app/screens/home/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatelessWidget {
  static const String routeName='/home_screen_view';

  final HomeScreenController _controller= Get.put(HomeScreenController());
  var screenHeight=0.0;
  var screenWidth=0.0;

  HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight= MediaQuery.of(context).size.height;
    screenHeight=mediaQueryHeight;
    var mediaQueryWidth= MediaQuery.of(context).size.width;
    screenWidth=mediaQueryWidth;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('E-commerce app')),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search)
          ),
          IconButton(
              onPressed: (){},
              icon: Badge(
                badgeContent: Obx(()=>Text(_controller.localDataList.length.toString())),
                  child: const Icon(Icons.shopping_cart))
          ),
        ],
        // bottom: TabBar(
        //   controller: _controller.tabController,
        //   tabs: [
        //     Text('Home'),
        //     Text('Category'),
        //     Text('Profile'),
        //     Text('Cart'),
        //   ],
        // ),
      ),
      drawer: const Drawer(),
      body: TabBarView(
        controller: _controller.tabController,
          children:[
            Container(
              margin: const EdgeInsets.all(10),
              color: const Color(0x0ff0f2f5),
              child: _HomeTab()
            ),
            Container(
              color: Colors.greenAccent,
              child: const Center(child: Text('Category Page')),
            ),
            Container(
              child: _cartTab(),
              //color: Colors.amber,
            ),
            Container(
              color: Colors.blue,
              child: const Center(child: Text('Profile Page')),
            ),
          ] ),
      bottomNavigationBar: GetBuilder<HomeScreenController>(builder: (controller)=>BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
           selectedItemColor: Colors.blue ,
           unselectedItemColor: Colors.black ,
           currentIndex: controller.tabController.index,
           onTap: (index){
             print('Sending$index');
             controller.tabController.index=index;
             controller.update();
             print('Received$index');
           },
           items: [
             const BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                 label: 'Home'
             ),
             const BottomNavigationBarItem(
                 icon: Icon(Icons.category),
                 label: 'Category'
             ),
             BottomNavigationBarItem(
                 icon: Badge(
                   badgeContent: Obx(()=>Text(_controller.localDataList.length.toString())),
                     child: const Icon(Icons.shopping_cart)),
                 label: 'Cart'
             ),
             const BottomNavigationBarItem(
                 icon: Icon(Icons.person),
                 label: 'Profile'
             ),
           ]
       ),),
    );
  }

 Widget _HomeTab() {
    return Scrollbar(
      child: SingleChildScrollView(
        controller: _controller.scrollbarController,
        child: Column(
            children: [
              _sliderWidget(),
              _productsGridView(),
            ],
        )
      ),
    );
 }

 Widget _sliderWidget() {
      return CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, realIndex) => Container(
            child: Image.asset('assets/slider-ecom-home-page.jpg', fit: BoxFit.cover,),
          ),
          options: CarouselOptions(
            height: screenWidth/3,
            autoPlay: true,
            disableCenter: true,
            pauseAutoPlayOnTouch: true,
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (a, reason){},
          ));
  }

 Widget _productsGridView() {
    return Container(
      height: 500,
      child: Obx(()=>GridView.builder(
          itemCount: _controller.productDataList.length??0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth>500?4:2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0
          ),
          itemBuilder:(context, index) => InkWell(
            onTap: (){
              print('Index:$index');
              //Get.find<ProductDetailsController>().selectedItemIndex.value=index; //Data stored by Another dependency injection
              Get.put(ProductDetailsController()).selectedItemIndex.value=index; // Data stored by Dependency injection example-one
              print('Index Received:${Get.put(ProductDetailsController()).selectedItemIndex.value}');
              Get.toNamed(ProductDetails.routeName);
            },
            child: ProductView(
              price:'\$${_controller.productDataList.value[index].price}',
              name: _controller.productDataList.value[index].name,
              image:API.productImageUrl+_controller.productDataList.value[index].image![0].toString(),
              isFavorite: _controller.productDataList.value[index].isFavorite??false,
              favoriteCallBack: () {
                print('Favorite Status:${_controller.productDataList.value![index].isFavorite}');
              },
              cartCallBack: () {
                _controller.insertShoppingCartData(HiveEntity(
                    name: '${_controller.productDataList.value[index].name}',
                    price: '\$${_controller.productDataList.value[index].price}',
                    id: '${_controller.productDataList.value[index].id}',
                    image: API.productImageUrl+_controller.productDataList.value[index].image![0].toString(),
                    quantity: 1));
              },
            ),
          ))),
    );
 }

  _cartTab() {
    _controller.getLocalData();
    return Obx(()=>ListView.builder(
      itemCount: _controller.localDataList.length,
      itemBuilder: (context, index) => Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: Colors.grey.shade300,
          ),
          margin: EdgeInsets.only(left:screenWidth*0.01, right: screenWidth*0.0, top: 5),
          child: Row(
            children: [
              Container(
                //color: Colors.green,
                height: 120,
                width: screenWidth*0.3,
                child: Image.network(_controller.localDataList[index].image??''),
              ),
              Container(
                //color: Colors.blue,
                height: 120,
                width: screenWidth*0.61,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_controller.localDataList[index].name??'', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5),
                    Text(_controller.calculateItemTotalPrice(_controller.localDataList[index].price, _controller.localDataList[index].quantity), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 5),
                //color: Colors.blue,
                height: 120,
                width: screenWidth*0.07,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: const Center(child: Icon(Icons.add))),
                    const Center(child: Text('1')),
                    IconButton(onPressed: (){}, icon: const Center(child: Icon(Icons.minimize)))
                  ],
                ),
              )
            ],
          )),
    ));
  }
}
