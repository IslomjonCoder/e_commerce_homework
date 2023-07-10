import 'package:e_commerce_homework/ui/favourites_screen.dart';
import 'package:e_commerce_homework/ui/products_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pages = [ProductsScreen(), FavouritesScreen()];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selected],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (value) {
            selected = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Products'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites'),
          ]),
    );
  }
}
