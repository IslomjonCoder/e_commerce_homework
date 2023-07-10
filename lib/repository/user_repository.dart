import 'package:e_commerce_homework/models/product/product_model.dart';
import 'package:e_commerce_homework/models/token/token_model.dart';
import 'package:e_commerce_homework/models/universal_model.dart';
import 'package:e_commerce_homework/models/user/user_model.dart';
import 'package:e_commerce_homework/repository/api_provider.dart';

class UserRepository {
  final ApiProvider apiProvider;

  UserRepository({required this.apiProvider});

  Future<UserModel?> getAllUsers() async {
    UniversalResponse response = await apiProvider.getAllUsers();
    if (response.error.isEmpty) {
      return response.data as UserModel;
    }
    return null;
  }

  Future<TokenModel?> loginUser({required UserModel user}) async {
    UniversalResponse response = await apiProvider.loginUser(user);
    if (response.error.isEmpty) {
      return response.data as TokenModel;
    }
    return null;
  }
}
