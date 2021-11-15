import 'dart:convert';
class HomeModel{
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String ,dynamic> json){
    status = json["status"];
    message = json["message"];
    data = HomeDataModel.fromJson(json["data"]);
  }

}
class HomeDataModel{
  List<BannerModel> banners=[] ;
  List<ProductsModel> products=[] ;

  HomeDataModel.fromJson(Map<String,dynamic> json){
    if (json['banners'] != null) {
      banners = <BannerModel>[];
      json['banners'].forEach((v) {
        banners!.add(BannerModel.fromJson(v));
      });
    }

    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
  }

}

class BannerModel{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    image = json["image"];

  }

}

class ProductsModel{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  ProductsModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
    in_favorites = json["in_favorites"];
    in_cart = json["in_cart"];
  }
}