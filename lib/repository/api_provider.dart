import 'package:dio/dio.dart';
import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/models/token/token_model.dart';
import 'package:e_commerce_homework/models/universal_model.dart';
import 'package:e_commerce_homework/models/user/user_model.dart';

class ApiProvider {
  Dio dio = Dio();

  //------------------------------Product provider------------------------------

  Future<UniversalResponse> getProductsByLimit({required int limit}) async {
    String url = 'https://fakestoreapi.com/products?limit=$limit';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (response.data as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getAllProducts() async {
    String url = 'https://fakestoreapi.com/products';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (response.data as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getProductById({required int id}) async {
    String url = 'https://fakestoreapi.com/products/$id';
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        return UniversalResponse(data: ProductModel.fromJson(response.data));
      } else if (response.statusCode != 200) {
        return UniversalResponse(error: 'Error: Status code not equal to 200');
      }

      return UniversalResponse(error: 'Error: Product not found');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> addProduct(ProductModel product) async {
    String url = 'https://fakestoreapi.com/products';
    try {
      final response = await dio.post(url, data: product.toJson());
      if (response.statusCode == 200) {
        return UniversalResponse(data: ProductModel.fromJson(response.data));
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> addProductUpdate(ProductModel product) async {
    String url = 'https://fakestoreapi.com/products/${product.id}';
    try {
      final response = await dio.put(url, data: product.toJson());
      if (response.statusCode == 200) {
        return UniversalResponse(data: ProductModel.fromJson(response.data));
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> deleteProduct(ProductModel product) async {
    String url = 'https://fakestoreapi.com/products/${product.id}';
    try {
      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        return UniversalResponse(data: product);
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> sortProducts() async {
    String url = 'https://fakestoreapi.com/products?sort=desc';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (response.data as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------User provider---------------------------------

  Future<UniversalResponse> getAllUsers() async {
    String url = 'https://fakestoreapi.com/users';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (response.data as List)
              .map((e) => UserModel.fromJson(e))
              .toList(),
        );
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------Login provider--------------------------------

  Future<UniversalResponse> loginUser(
      {required String username, required String password}) async {
    String url = 'https://fakestoreapi.com/auth/login';
    try {
      final response = await dio
          .post(url, data: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return UniversalResponse(data: TokenModel.fromJson(response.data));
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  //------------------------------Category provider-----------------------------

  Future<UniversalResponse> getAllCategories() async {
    String url = 'https://fakestoreapi.com/products/categories';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        print(response.data.runtimeType);
        return UniversalResponse(data: response.data);
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }

  Future<UniversalResponse> getProductsByCategories(
      {String category = 'jewelery'}) async {
    String url = 'https://fakestoreapi.com/products/category/$category';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (response.data as List)
                .map((e) => ProductModel.fromJson(e))
                .toList());
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      return UniversalResponse(error: e.toString());
    }
  }
}
