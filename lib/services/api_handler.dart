import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/consts/api_const.dart';
import 'package:store_app/models/CategoriesModel.dart';
import 'package:store_app/models/ProductsModel.dart';
import 'package:store_app/models/UsersModel.dart';

class APIHandler {
  // https://api.escuelajs.co/api/v1/products
//======================global method===================================================================
  static Future<List<dynamic>> getData({required String target}) async {
    try {
      var uri = Uri.https(BASE_URL, '/api/v1/$target');
      var response = await http.get(uri);
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data['message'];
      }

      for (var v in data) {
        tempList.add(v);
      }
      return tempList;
    } catch (error) {
      throw error.toString();
    }
  }

//=====================fetch Api Of Products=============================================================
  static Future<List<ProductsModel>> getAllProducts() async {
    List temp = await getData(target: 'products');
    return ProductsModel.productsFromSnapshot(temp);
  }

//=====================fetch Api of Categories===========================================================
  static Future<List<CategoriesModel>> getAllCategories() async {
    List temp = await getData(target: 'categories');

    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  //======================fetch Users data from Apis=======================================================
  static Future<List<UsersModel>> getAllUsers() async {
    List temp = await getData(target: 'users');
    return UsersModel.usersFromSnapshot(temp);
  }

//===================get product by Id====================================================================
  static Future<ProductsModel> getProductById({required String id}) async {
    try {
      var uri = Uri.https(BASE_URL, '/api/v1/products/$id');
      var response = await http.get(uri);
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data['message'];
      }
      return ProductsModel.fromJson(data);
    } catch (error) {
      throw error.toString();
    }
  }
}
