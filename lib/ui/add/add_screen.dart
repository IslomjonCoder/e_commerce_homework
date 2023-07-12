import 'dart:io';

import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/ui/login/widgets/universal_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // List cats;
  late TextEditingController name;

  late TextEditingController priceController;

  late TextEditingController description;

  @override
  void initState() {
    name = TextEditingController();
    priceController = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  late File imageFile = File('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'),
        actions: [
          IconButton(
              onPressed: () async {
                print([name.text, priceController.text, description.text]);

                final result =
                    await ProductRepository(apiProvider: ApiProvider())
                        .addProduct(
                            product: ProductModel(
                  title: name.text,
                  price: 0.0,
                  description: description.text,
                  category: 'electorincs',
                  image: 'http:/',
                ));
                print(result);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text((result == null)
                        ? 'Product is not valid'
                        : "Product is added " + result.toString())));
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UniversalInput(
                  label: 'Name', hint: 'Enter product name', controller: name),
              UniversalInput(
                  label: 'Price',
                  hint: 'Enter product price',
                  keyboardType: TextInputType.number,
                  controller: priceController),
              UniversalInput(
                  label: 'Description',
                  hint: 'Enter product description',
                  maxLine: 4,
                  controller: description),

              if (imageFile.path.isEmpty)
                ElevatedButton(
                    onPressed: () async {
                      print('ok3');
                      getImage();
                      print('ok4');
                    },
                    child: const Text('Get Image'))
              else
                Image.file(
                  imageFile,
                  fit: BoxFit.scaleDown,
                  height: 400,
                ),
              // DropdownButton(
              //     items: List.generate(cats.length,
              //         (index) => DropdownMenuItem(child: Text(cats[index]))),
              //     onChanged: (e) {})
            ],
          ),
        ),
      ),
    );
  }

  getImage() async {
    print('ok1');
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      print('ok');
      imageFile = File(pickedFile.path);
    }
    setState(() {});
  }
}
