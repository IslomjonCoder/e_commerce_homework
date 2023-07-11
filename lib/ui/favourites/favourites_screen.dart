import 'package:e_commerce_homework/ui/detail/detail_screen.dart';
import 'package:e_commerce_homework/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late final Box box;
  List favoriteProducts = [];
  @override
  void initState() {
    box = Hive.box('favourites');
    favoriteProducts = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: GridView.builder(
        itemCount: favoriteProducts.length,
        padding: EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            mainAxisSpacing: 24,
            childAspectRatio: 0.60,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(product: product),
                  ));
            },
            child: ProductWidget(
              product: product,
              isSelected: true,
            ),
          );
        },
      ),
    );
  }
}
