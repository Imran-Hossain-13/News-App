import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/models/db_news-model.dart';
import 'package:news/res/routes/routes_name.dart';
import 'package:news/view_model/news_view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../models/categories_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final dateFormat = DateFormat("MMMM, dd, yyyy");


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: size.width *.04),
          child: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back_ios,size: 37,),
          ),
        ),
        title: Text("DN News",style: GoogleFonts.poppins(textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700
        )),),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width *.04),
            child: IconButton(
              onPressed: (){
                Get.toNamed(RoutesName.categoriesScreen);
              },
              icon: Image.asset("images/category_icon.png",height: 27,width: 27,),
            ),
          )
        ],
      ),
      body:ListView(
        children: [
          SizedBox(
          height: size.height * .55,
          child: FutureBuilder<DnNewsModel>(
            future: newsViewModel.fetchDbNewsData(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: SpinKitCircle(
                    size: 50,
                    color: Colors.blue,
                  ),
                );
              }else{
                return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
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
                        child: SizedBox(
                          height: size.height * .6,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: size.width,
                                height: size.height * .6,
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width *.04,
                                  vertical: size.height *.02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>const SpinKitFadingCircle(size: 50,color: Colors.amber,),
                                    errorWidget: (context, url, error) =>const Center(child: Icon(Icons.error_outlined,color: Colors.red,size: 50,)),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 25,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: size.height * .22,
                                    width: size.width *.85,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title.toString(),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style:const TextStyle(fontSize: 17,fontWeight: FontWeight.w700),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].source!.name.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.blue),
                                            ),
                                            Text(
                                              dateFormat.format(dateTime),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                );
              }
            },
          ),
        ),
          Padding(
            padding: const EdgeInsets.all(15),
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
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
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
          )
        ],
      ),
    );
  }
}
