import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';
import 'package:e_commerce_homework/repository/product_repository.dart';
import 'package:e_commerce_homework/ui/edit/edit_screen.dart';
import 'package:e_commerce_homework/ui/home/home_screen.dart';
import 'package:e_commerce_homework/utils/colors.dart';
import 'package:e_commerce_homework/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.product}) : super(key: key);
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: AppTextStyles.mediumBody1.copyWith(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(product: product),
                    ));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                final result =
                    await ProductRepository(apiProvider: ApiProvider())
                        .deleteProduct(product: product);
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product is not deleted')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product succesfully deleted')));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                }
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 458,
                child: CachedNetworkImage(imageUrl: product.image)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppTextStyles.mediumBody1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: product.rating!.rate,
                            // initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          Text(
                            // product.rating!.rate.toString(),
                            product.rating!.rate.toString(),
                            style: AppTextStyles.regularBody1,
                          )
                        ],
                      ),
                      Text(
                        "${product.rating?.count}" + ' ordered',
                        style: AppTextStyles.regularBody1,
                      )
                    ],
                  ),
                  Text(
                    r"$" + product.price.toString(),
                    style: AppTextStyles.semiboldHeading2,
                  ),
                  Text(
                    "Category: " + product.category,
                    style: AppTextStyles.regularBody1,
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.description,
                    textAlign: TextAlign.justify,
                    style: AppTextStyles.regularBody1
                        .copyWith(color: ColorsApp.giratina500),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Order'),
                        style: ButtonStyle(),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
