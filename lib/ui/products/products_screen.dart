import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/category_repository.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/utils/style.dart';
import 'package:e_commerce_homework/widgets/get_product_future_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen(
      {Key? key,
      required this.productRepository,
      required this.categoryRepository})
      : super(key: key);
  final ProductRepository productRepository;
  final List categoryRepository;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ApiProvider provider = ApiProvider();
  List categories = [];
  late Future path;
  int selected = 0;
  bool sorted = false;

  @override
  void initState() {
    path = ProductRepository(apiProvider: provider).getAllProducts();
    categories = ['All', ...widget.categoryRepository];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              title: Text('Users'),
              leading: Icon(Icons.supervised_user_circle),
            )
          ],
        )),
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            IconButton(
                isSelected: sorted,
                onPressed: () {
                  path = sorted
                      ? ProductRepository(apiProvider: provider).sortProducts()
                      : ProductRepository(apiProvider: provider)
                          .getAllProducts();
                  sorted = !sorted;
                  setState(() {});
                },
                icon: Icon(Icons.sort))
          ],
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
