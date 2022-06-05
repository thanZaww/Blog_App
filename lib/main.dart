import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rest_api_blog/data/api_service/post_api_service.dart';
import 'package:get/get.dart';
import '/widget/bottom_nav.dart';

void main() {
  Get.put(PostApiService());
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // darkTheme: ThemeData.dark(),
      home: const BottomNav(),
    );
  }
}
