import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/models/token/token_model.dart';
import 'package:e_commerce_homework/models/universal_model.dart';
import 'package:e_commerce_homework/models/user/user_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';

class ProductRepository {
  final ApiProvider apiProvider;

  ProductRepository({required this.apiProvider});

  Future<List<ProductModel>> getProductsByLimit({int limit = 5}) async {
    UniversalResponse response =
        await apiProvider.getProductsByLimit(limit: limit);
    if (response.error.isEmpty) {
      return response.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> getAllProducts() async {
    UniversalResponse response = await apiProvider.getAllProducts();
    if (response.error.isEmpty) {
      return response.data as List<ProductModel>;
    }
    return [];
  }

  Future<ProductModel?> getProductById({required int id}) async {
    UniversalResponse response = await apiProvider.getProductById(id: id);
    if (response.error.isEmpty) {
      return response.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> addProduct({required ProductModel product}) async {
    UniversalResponse response = await apiProvider.addProduct(product);
    if (response.error.isEmpty) {
      return response.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> addProductUpdate(
      {required ProductModel product}) async {
    UniversalResponse response = await apiProvider.addProductUpdate(product);
    if (response.error.isEmpty) {
      return response.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> deleteProduct({required ProductModel product}) async {
    UniversalResponse response = await apiProvider.deleteProduct(product);
    if (response.error.isEmpty) {
      return response.data as ProductModel;
    }
    return null;
  }

  Future<List<ProductModel>> sortProducts() async {
    UniversalResponse response = await apiProvider.sortProducts();
    if (response.error.isEmpty) {
      return response.data as List<ProductModel>;
    }
    return [];
  }
}
