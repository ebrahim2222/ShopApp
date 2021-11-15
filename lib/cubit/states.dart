import 'package:shop_app/model/login_model.dart';

abstract class ShopStates{}

class InitialShopStates extends ShopStates{}

class shopLoginLoadingState extends ShopStates{}
class shopLoginSuccessState extends ShopStates{
  LoginModel model;
  shopLoginSuccessState(this.model);
}
class shopLoginErrorState extends ShopStates{
  final String error;
  shopLoginErrorState(this.error);
}