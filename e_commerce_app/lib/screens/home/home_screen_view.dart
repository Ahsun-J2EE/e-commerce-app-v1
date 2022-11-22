import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/Utils/api.dart';
import 'package:e_commerce_app/Utils/hive_database/hive_entity.dart';
import 'package:e_commerce_app/screens/category/product_view.dart';
import 'package:e_commerce_app/screens/home/home_screen_controller.dart';
import 'package:e_commerce_app/screens/home/product_details.dart';
import 'package:e_commerce_app/screens/home/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

class HomeScreenView extends StatelessWidget {
  static const String routeName='/home_screen_view';

  final HomeScreenController _controller= Get.put(HomeScreenController());
  var screenHeight=0.0;
  var screenWidth=0.0;

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight= MediaQuery.of(context).size.height;
    screenHeight=mediaQueryHeight;
    var mediaQueryWidth= MediaQuery.of(context).size.width;
    screenWidth=mediaQueryWidth;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(child: Text('E-commerce app')),
        actions: [
          // IconButton(
          //     onPressed: (){},
          //     icon: const Icon(Icons.search)
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 5),
            child: Badge(
              badgeContent: Obx(()=>Text(_controller.localDataList.length.toString())),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
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
      drawer: Drawer(),
      body: Container(
        child: TabBarView(
          controller: _controller.tabController,
            children:[
              Container(
                margin: EdgeInsets.all(10),
                color: Color(0xFF0F2F5),
                child: _HomeTab()
              ),
              Container(
                child: Center(child: Text('Category Page')),
                color: Colors.greenAccent,
              ),
              Container(
                child: Center(child: Text('Profile Page')),
                color: Colors.blue,
              ),
              Container(
                child: _cartTab(),
                //color: Colors.amber,
              ),
            ] ),
      ),
      bottomNavigationBar: GetBuilder<HomeScreenController>(builder: (_controller)=>BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
           selectedItemColor: Colors.blue ,
           unselectedItemColor: Colors.black ,
           currentIndex: _controller.tabController.index,
           onTap: (index){
             print('Sending$index');
             _controller.tabController.index=index;
             _controller.update();
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
             const BottomNavigationBarItem(
                 icon: Icon(Icons.person),
                 label: 'Profile'
             ),
             BottomNavigationBarItem(
                 icon: Badge(
                   badgeContent: Obx(()=>Text(_controller.localDataList.length.toString())),
                   child: const Icon(Icons.shopping_cart_outlined),
                 ),
                 label: 'Cart'
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
                    image: API.productImageUrl+_controller.productDataList.value[index].image![0].toString()));
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
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
          ),
          margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Center(child: Text(_controller.localDataList[index].name.toString()))),
    ));
  }
}
