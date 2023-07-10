import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/category_repository.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/utils/style.dart';
import 'package:e_commerce_homework/widgets/get_product_future_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ApiProvider provider = ApiProvider();
  List categories = ['All'];
  late Future path;
  int selected = 0;

  @override
  void initState() {
    path = ProductRepository(apiProvider: provider).getAllProducts();
    getCategories();
    super.initState();
  }

  getCategories() async {
    categories.addAll(
        await CategoryRepository(apiProvider: provider).getAllCategories());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selected = index;
                      path = (index == 0)
                          ? ProductRepository(apiProvider: provider)
                              .getAllProducts()
                          : path = CategoryRepository(apiProvider: provider)
                              .getProductsByCategories(
                                  categoryName: categories[index]);

                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (selected == index)
                              ? Colors.black
                              : Colors.white),
                      child: Text(
                        (categories[index] as String),
                        style: AppTextStyles.mediumBody3.copyWith(
                            color: (selected == index)
                                ? Colors.white
                                : Colors.black),
                      ),
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
              child: CustomFuture(future: path),
            ),
          ],
        ));
  }
}
