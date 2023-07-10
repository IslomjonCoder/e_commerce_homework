import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomFuture extends StatefulWidget {
  CustomFuture({Key? key, required this.future}) : super(key: key);
  Future future;

  @override
  State<CustomFuture> createState() => _CustomFutureState();
}

class _CustomFutureState extends State<CustomFuture> {
  late final Box box;
  List savedProducts = [];

  @override
  void initState() {
    box = Hive.box('favourites');
    savedProducts = box.values.map((e) => e.id).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data!;
            return GridView.builder(
              itemCount: products.length,
              padding: EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.60,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductWidget(
                  product: product,
                  isSelected: savedProducts.contains(product.id),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: Text('Error'));
        },
        future: widget.future);
  }
}
