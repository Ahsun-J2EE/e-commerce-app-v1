import 'package:flutter/material.dart';
class ProductView extends StatelessWidget {
  String? price;
  String? name;
  String? image;
  bool isFavorite=false;
  VoidCallback favoriteCallBack;
  VoidCallback cartCallBack;

  ProductView({super.key,
   required this.price,
   required this.name,
   required this.image,
   required this.isFavorite,
   required this.favoriteCallBack,
   required this.cartCallBack
});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
                top: BorderSide(color: Colors.grey),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          height: 200,
          width: double.infinity,
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                height: 80,
                padding: EdgeInsets.all(8),
                child: Image.network(image!,fit: BoxFit.cover,),
              ),
              Container(
                height: 30,
                child: Text(name!),
              ),
              Container(
                height: 30,
                child: Text(price!),
              ),
            ],
          ),
        ),
        Positioned(
            left: 10,
            top: 10,
            child: IconButton(
                onPressed: favoriteCallBack,
                icon: Icon(isFavorite==false?Icons.favorite_outline:Icons.favorite))
        ),
        Positioned(
          right: 10,
            top: 10,
            child: IconButton(
                onPressed: cartCallBack,
                icon: Icon(Icons.shopping_cart))
        ),
      ],
    );
  }
}
