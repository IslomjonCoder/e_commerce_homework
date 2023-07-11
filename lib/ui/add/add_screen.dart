import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/ui/login/widgets/universal_input.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  // List cats;
  TextEditingController name = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'),
        actions: [
          IconButton(
              onPressed: () {
                ProductRepository(apiProvider: ApiProvider()).addProduct(
                    product: ProductModel(
                  title: name.text,
                  price: double.parse(priceController.text),
                  description: description.text,
                  category: '',
                  image:
                      'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-math-90946.jpg&fm=jpg',
                ));
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            UniversalInput(
                label: 'Name', hint: 'Enter product name', controller: name),
            UniversalInput(
                label: 'Price',
                hint: 'Enter product price',
                controller: priceController),
            UniversalInput(
                label: 'Description',
                hint: 'Enter product description',
                maxLine: 4,
                controller: description),
            // DropdownButton(
            //     items: List.generate(cats.length,
            //         (index) => DropdownMenuItem(child: Text(cats[index]))),
            //     onChanged: (e) {})
          ],
        ),
      ),
    );
  }
}
