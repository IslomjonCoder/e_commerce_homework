import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/category_repository.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/utils/colors.dart';
import 'package:e_commerce_homework/utils/style.dart';
import 'package:e_commerce_homework/widgets/get_product_future_widgets.dart';
import 'package:e_commerce_homework/widgets/product_widget.dart';
import 'package:e_commerce_homework/widgets/saved_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiProvider provider = ApiProvider();
  List categories = ['All'];
  List sorting = [];

  late final Box box;

  @override
  void initState() {
    box = Hive.box('categories');
    sorting = [
      ProductRepository(apiProvider: provider).getAllProducts(),
    ];
    getCategories();
    super.initState();
  }

  getCategories() async {
    categories = box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              height: 104,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 88,
                      width: 88,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          (categories[index] as String),
                          maxLines: 2,
                          style: AppTextStyles.mediumBody3
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 12,
                ),
                itemCount: categories.length,
              ),
            ),
            Expanded(
              child: CustomFuture(
                  future: ProductRepository(apiProvider: provider)
                      .getAllProducts()),
            ),
          ],
        ));
  }
}
