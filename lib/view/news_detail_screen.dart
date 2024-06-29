import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailScreen extends StatefulWidget {
  // final String newsImage, newsTitle, newsDate, author, description, content, source;
  const NewsDetailScreen({
    super.key,
    // required this.newsImage, required this.newsTitle,
    // required this.newsDate, required this.author, required this.description,
    // required this.content, required this.source
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: Stack(
        children: [
          SizedBox(
            height: size.height * .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
              child: CachedNetworkImage(
                imageUrl: Get.arguments[0],
                fit: BoxFit.cover,
                placeholder: (context, url) => const SpinKitFadingCircle(size: 50,color: Colors.amber,),
              ),
            ),
          ),
          Container(
            height: size.height * .6,
            margin: EdgeInsets.only(top: size.height * .4),
            padding: const  EdgeInsets.only(top: 20,left: 20,right: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: ListView(
              children: [
                Text(
                  Get.arguments[1],
                  style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w700,fontSize: 20)),
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Get.arguments[6],
                      style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 15)),
                    ),
                    Text(
                      Get.arguments[2],
                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Text(
                  Get.arguments[4],
                  style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
