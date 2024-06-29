import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/res/routes/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
    )
  );
}

