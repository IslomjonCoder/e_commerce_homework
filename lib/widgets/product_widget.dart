import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/utils/colors.dart';
import 'package:e_commerce_homework/utils/style.dart';
import 'package:e_commerce_homework/widgets/saved_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({Key? key, required this.product, required this.isSelected})
      : super(key: key);
  ProductModel product;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
              imageUrl: product.image, fit: BoxFit.scaleDown),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 4),
          height: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                r"$" + "${product.price}",
                style:
                    AppTextStyles.mediumBody1.copyWith(color: ColorsApp.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SavedIcon(product: product, isSelected: isSelected)
            ],
          ),
        ),
        Text(
          product.description,
          style:
              AppTextStyles.regularBody3.copyWith(color: ColorsApp.giratina500),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )
      ],
    );
  }
}
