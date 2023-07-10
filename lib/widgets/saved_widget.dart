import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SavedIcon extends StatefulWidget {
  SavedIcon({Key? key, required this.product, required this.isSelected})
      : super(key: key);
  ProductModel product;
  bool isSelected = false;

  @override
  State<SavedIcon> createState() => _SavedIconState();
}

class _SavedIconState extends State<SavedIcon> {
  late final Box box;

  @override
  void initState() {
    box = Hive.box('favourites');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        (!box.values.map((e) => e.id).toList().contains(widget.product.id))
            ? box.put(widget.product.id, widget.product)
            : box.delete(widget.product.id);

        widget.isSelected = !widget.isSelected;
        setState(() {});
      },
      icon: Center(
        child: Icon(
          widget.isSelected ? Icons.favorite : Icons.favorite_border,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
