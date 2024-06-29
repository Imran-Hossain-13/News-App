import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news/res/routes/routes_name.dart';
import 'package:news/view/categories_screen.dart';
import 'package:news/view/channel_selector.dart';
import 'package:news/view/home_screen.dart';
import 'package:news/view/login_screen.dart';
import 'package:news/view/news_detail_screen.dart';
import 'package:news/view/splash_screen.dart';

class AppRoutes{
  static appRoutes() => [
    GetPage(name: RoutesName.splashScreen, page: () => const SplashScreen()),
    GetPage(name: RoutesName.loginScreen, page: () => const LoginScreen()),
    GetPage(name: RoutesName.homeScreen, page: () => const HomeScreen()),
    GetPage(name: RoutesName.channelSelectorScreen, page: () => const ChannelSelector()),
    GetPage(name: RoutesName.categoriesScreen, page: () => const CategoriesScreen()),
    GetPage(name: RoutesName.newsDetailScreen, page: () => const NewsDetailScreen()),
  ];
}