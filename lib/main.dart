import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/models/product/rating_model.dart';
import 'package:e_commerce_homework/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingModelAdapter());
  // await Hive.openBox('categories');
  await Hive.openBox('favourites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // home: HomeScreen(),
    );
  }
}
