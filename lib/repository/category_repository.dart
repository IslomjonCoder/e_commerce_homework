import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/models/universal_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';

class CategoryRepository {
  final ApiProvider apiProvider;

  CategoryRepository({required this.apiProvider});

  Future<List> getAllCategories() async {
    UniversalResponse response = await apiProvider.getAllCategories();
    if (response.error.isEmpty) {
      return response.data;
    }
    return [];
  }

  Future<List<ProductModel>> getProductsByCategories(
      {required String categoryName}) async {
    UniversalResponse response =
        await apiProvider.getProductsByCategories(category: categoryName);
    if (response.error.isEmpty) {
      return response.data as List<ProductModel>;
    }
    return [];
  }
}
