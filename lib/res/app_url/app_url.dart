import 'package:get/get.dart';

class AppUrl{
  RxString baseUrl ="https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=8d45f2f889004b71acdc9521a6743831".obs;
  RxString categoriesUrl ="https://newsapi.org/v2/everything?q=general&apiKey=8d45f2f889004b71acdc9521a6743831".obs;
  RxString categoryName = "general".obs;
  changeChannel(String newsChannel){
    baseUrl.value = "https://newsapi.org/v2/top-headlines?sources=$newsChannel&apiKey=8d45f2f889004b71acdc9521a6743831";
  }

  changeCategories(String categories){
    categoriesUrl.value = "https://newsapi.org/v2/everything?q=$categories&apiKey=8d45f2f889004b71acdc9521a6743831";
  }

  changeCategoryName(String changedCategoryName){
    categoryName.value = changedCategoryName;
  }
}