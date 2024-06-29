import 'package:news/models/categories_news_model.dart';
import 'package:news/models/db_news-model.dart';
import 'package:news/repository/db_news_reppository.dart';

class NewsViewModel{
  final _rep = DnNewsRepository();
  Future<DnNewsModel> fetchDbNewsData()async{
    final response = await _rep.fetchDbNewsData();
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi()async{
    final response = await _rep.fetchCategoriesNewsApi();
    return response;
  }
}