import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/categories_news_model.dart';
import 'package:news/res/app_url/app_url.dart';
import '../models/db_news-model.dart';

class DnNewsRepository{
  AppUrl appUrl = Get.put(AppUrl());
  Future<DnNewsModel> fetchDbNewsData() async{
    final response = await http.get(Uri.parse(appUrl.baseUrl.value));
    if(response.statusCode == 200){
      return DnNewsModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error");
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi() async{
    final response = await http.get(Uri.parse(appUrl.categoriesUrl.value));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error");
    }
  }
}