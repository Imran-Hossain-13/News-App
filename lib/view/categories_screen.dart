import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/models/categories_news_model.dart';
import 'package:news/res/app_url/app_url.dart';
import '../res/routes/routes_name.dart';
import '../view_model/news_view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  AppUrl appUrl = Get.put(AppUrl());
  final dateFormat = DateFormat("MMMM, dd, yyyy");
  List<String> btnCategories = ["General", "Entertainment","Health", "Sports","Business", "Technology"];


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: size.width *.04),
          child: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back_ios,size: 37,),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: btnCategories.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      appUrl.changeCategoryName(btnCategories[index].toLowerCase());
                      appUrl.changeCategories(btnCategories[index].toLowerCase());
                      // setState(() { });
                    },
                    child: Obx(() {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: appUrl.categoryName.value.toLowerCase() == btnCategories[index].toLowerCase()?Colors.blue:Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(child: Text(
                          btnCategories[index].toString(),
                          style: TextStyle(
                              color: appUrl.categoryName.value.toLowerCase() == btnCategories[index].toLowerCase()?Colors.white:Colors.black,
                              fontWeight: FontWeight.w700
                          ),
                        )),
                      );
                    }),
                  );
                }
              ),
            ),
            const SizedBox(height: 20,),
            Obx(() {return Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }else if(!snapshot.hasData){
                    return Center(child: Container(
                      height: size.height * .2,
                      width: size.width * .4,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff130126),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: const Center(child: Text("Data not found",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.w600),)),
                    ),);
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index){
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          var value = appUrl.categoryName.value; //just for use obx
                          return InkWell(
                            onTap: (){
                              Get.toNamed(RoutesName.newsDetailScreen,arguments: [
                                snapshot.data!.articles![index].urlToImage.toString(),
                                snapshot.data!.articles![index].title.toString(),
                                dateFormat.format(dateTime),
                                snapshot.data!.articles![index].author.toString(),
                                snapshot.data!.articles![index].description.toString(),
                                snapshot.data!.articles![index].content.toString(),
                                snapshot.data!.articles![index].source!.name.toString(),
                              ]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      height: size.height * .18,
                                      width: size.width * .3,
                                      placeholder: (context, url) =>const SpinKitFadingCircle(size: 50,color: Colors.amber,),
                                      errorWidget: (context, url, error) =>const Center(child: Icon(Icons.error_outlined,color: Colors.red,size: 50,)),
                                    ),
                                  ),
                                  Expanded(child: Container(
                                    height: size.height * .18,
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title.toString(),
                                          maxLines: 4,
                                          style: GoogleFonts.poppins(textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700
                                          )),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].source!.name.toString(),
                                              style: GoogleFonts.poppins(textStyle: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600
                                              )),
                                            ),
                                            Text(
                                              dateFormat.format(dateTime),
                                              style: GoogleFonts.poppins(textStyle: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500
                                              )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
                },
              ),
            );}),

          ],
        ),
      ),
    );
  }
}
