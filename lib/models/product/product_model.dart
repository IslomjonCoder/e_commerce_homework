import 'package:e_commerce_homework/models/product/rating_model.dart';
import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;
  @HiveField(3)
  String description;
  @HiveField(4)
  String category;
  @HiveField(5)
  String image;
  @HiveField(6)
  RatingModel? rating;

  ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"] ?? '',
        price: json["price"]?.toDouble() ?? 0.0,
        description: json["description"] ?? '',
        category: json["category"] ?? '',
        image: json["image"] ?? '',
        rating: RatingModel.fromJson(json["rating"]) ??
            RatingModel(count: 0, rate: 0.0),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
      };
  @override
  String toString() {
    return "$title, $price,$description";
    return super.toString();
  }
}
