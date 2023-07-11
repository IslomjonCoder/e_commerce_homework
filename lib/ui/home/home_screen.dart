import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/category_repository.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/repository/user_repository.dart';
import 'package:e_commerce_homework/ui/add/add_screen.dart';
import 'package:e_commerce_homework/ui/favourites/favourites_screen.dart';
import 'package:e_commerce_homework/ui/products/products_screen.dart';
import 'package:e_commerce_homework/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [];
  int selected = 0;
  ApiProvider provider = ApiProvider();
  late UserRepository userRepository;
  late ProductRepository productRepository;
  late CategoryRepository categoryRepository;
  @override
  void initState() {
    userRepository = UserRepository(apiProvider: provider);
    productRepository = ProductRepository(apiProvider: provider);
    categoryRepository = CategoryRepository(apiProvider: provider);
    loadPages();

    super.initState();
  }

  loadPages() async {
    pages.addAll([
      ProductsScreen(
          productRepository: productRepository,
          categoryRepository: await categoryRepository.getAllCategories()),
      AddScreen(),
      FavouritesScreen(),
    ]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (pages.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : pages[selected],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (value) {
            selected = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites'),
          ]),
    );
  }
}
