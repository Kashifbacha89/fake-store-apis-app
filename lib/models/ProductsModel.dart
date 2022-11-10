import 'package:flutter/cupertino.dart';
import 'package:store_app/models/CategoriesModel.dart';

/// id : 1
/// title : "Nuevo titulo curso de TS POO"
/// price : 1000
/// description : "new description junaid"
/// category : {"id":1,"name":"Clothes","image":"https://api.lorem.space/image/fashion?w=640&h=480&r=9923"}
/// images : ["https://api.lorem.space/image/fashion?w=640&h=480&r=4724","https://api.lorem.space/image/fashion?w=640&h=480&r=8481","https://api.lorem.space/image/fashion?w=640&h=480&r=3734"]

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  CategoriesModel? category;
  List<String>? images;

  ProductsModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoriesModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
  static List<ProductsModel> productsFromSnapshot(List productSnaphot) {
    // print("data ${productSnaphot[0]}");
    return productSnaphot.map((data) {
      return ProductsModel.fromJson(data);
    }).toList();
  }
}

