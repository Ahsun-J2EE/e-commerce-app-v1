
class API{

  static String baseUrl='https://grofresh-admin.6amtech.com';
  static String getBannerDataEndPoint='${baseUrl}/api/v1/banners';
  static String getCategoryDataEndPoint='${baseUrl}/api/v1/categories';
  static String getProductDataEndPoint='${baseUrl}/api/v1/products/latest?limit=10&&offset=1';

  //Image Url
  static String bannerImageUrl='https://demo/6amtech.com/grofresh/storage/app/public/banner';
  static String categoryImageUrl='https://grofresh-admin.6amtech.com/storage/app/public/category/';
  static String productImageUrl='https://grofresh-admin.6amtech.com/storage/app/public/product/';
}