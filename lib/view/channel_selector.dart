import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/res/routes/routes.dart';
import 'package:news/res/routes/routes_name.dart';
import 'package:news/view_model/preferences/login_pref.dart';

import '../res/app_url/app_url.dart';

class ChannelSelector extends StatefulWidget {
  const ChannelSelector({super.key});

  @override
  State<ChannelSelector> createState() => _ChannelSelectorState();
}

class _ChannelSelectorState extends State<ChannelSelector> {
  LoginPreferences loginPreferences = LoginPreferences();
  AppUrl appUrl = Get.put(AppUrl());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                              color: Colors.red[800],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Text("DN",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(width: 5,),
                        const Column(
                          children: [
                            Text("DAILY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            Text("NEWS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          ],
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("images/imon.jpg",),
                    ),
                  ],
                                ),
                ),
                SizedBox(height: size.height * .02,),
                const Text("Get nearby news on top",style: TextStyle(fontSize: 19,),),
                SizedBox(height: size.height * .13,),
                const Text("Select a news channel",style: TextStyle(fontSize: 23,letterSpacing: .9),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color(0xff130126),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChannelRowElement(
                        onTap: (){
                          appUrl.changeChannel("bbc-news");
                          Get.toNamed(RoutesName.homeScreen);
                        },
                        size: size,
                        imgUrl: "images/news_channel/bbc-news.png",
                        channelName: "BBC News",
                      ),
                      ChannelRowElement(
                        onTap: (){
                          appUrl.changeChannel("al-jazeera-english");
                          Get.toNamed(RoutesName.homeScreen);
                        },
                        size: size,
                        imgUrl: "images/news_channel/aljajira-news.png",
                        channelName: "Al Jazeera News",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChannelRowElement(
                        onTap: (){
                          appUrl.changeChannel("cnn");
                          Get.toNamed(RoutesName.homeScreen);},
                        size: size,
                        imgUrl: "images/news_channel/cnn-news.png",
                        channelName: "CNN News",
                      ),
                      ChannelRowElement(
                        onTap: (){
                          appUrl.changeChannel("nbc-news");
                          Get.toNamed(RoutesName.homeScreen);},
                        size: size,
                        imgUrl: "images/news_channel/independent-news.png",
                        channelName: "NBC News",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChannelRowElement(
                        onTap: (){
                          appUrl.changeChannel("reuters");
                          Get.toNamed(RoutesName.homeScreen);},
                        size: size,
                        imgUrl: "images/news_channel/reuters-channel.png",
                        channelName: "Reuters News",
                      ),
                      ChannelRowElement(
                        onTap: (){
                          loginPreferences.clearPreferences();
                          Get.offAndToNamed(RoutesName.loginScreen);
                        },
                        size: size,
                        imgUrl: "images/news_channel/log-out.png",
                        channelName: "Log Out",
                      ),
                    ],
                  ),
                ],
              ),
          ))
        ],
      ),
    );
  }
}

class ChannelRowElement extends StatelessWidget {
  const ChannelRowElement({
    super.key,
    required this.size, required this.imgUrl, required this.channelName, required this.onTap,
  });
  final VoidCallback onTap;
  final Size size;
  final String imgUrl;
  final String channelName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        width: size.width * .4,
        height: size.height * .16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Image.asset(imgUrl,width: size.width * .25,height: size.width * .25,),
            Text(channelName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
