import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/category_repository.dart';
import 'package:e_commerce_homework/ui/login/widgets/universal_input.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.product}) : super(key: key);
  ProductModel product;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List cats = [];
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.product.title);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
    load();
    super.initState();
  }

  load() async {
    // cats =
    // await CategoryRepository(apiProvider: ApiProvider()).getAllCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update product')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            UniversalInput(
                label: 'Username',
                hint: 'Enter your username',
                controller: _titleController),
            UniversalInput(
                label: 'Price',
                hint: 'Enter your price',
                controller: _priceController,
                keyboardType: TextInputType.number),
            UniversalInput(
              label: 'Description',
              hint: 'Enter your description',
              controller: _descriptionController,
              maxLine: 4,
            ),
            DropdownButton(items: [
              ...List.generate(cats.length,
                  (index) => DropdownMenuItem(child: Text(cats[index])))
            ], onChanged: (val) {})
          ],
        ),
      ),
    );
  }
}
