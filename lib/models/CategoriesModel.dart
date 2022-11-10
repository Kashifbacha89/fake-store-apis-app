
import 'package:flutter/cupertino.dart';

/// id : 1
/// name : "Clothes"
/// image : "https://api.lorem.space/image/fashion?w=640&h=480&r=9923"
class CategoriesModel with ChangeNotifier {
  int? id;
  String? name;
  String? image;

  CategoriesModel({this.id, this.name, this.image});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  static List<CategoriesModel> categoriesFromSnapshot(List categoriesSnaphot) {
    // print("data ${categoriesSnaphot[0]}");
    return categoriesSnaphot.map((data) {
      return CategoriesModel.fromJson(data);
    }).toList();
  }
}