import 'package:shop_app/model/favoirite_model.dart';
import 'package:shop_app/model/login_model.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeBottomNav extends HomeStates{}

class ShopLoadingHomeDataState extends HomeStates{}
class ShopSuccessHomeDataState extends HomeStates{}
class ShopErrorHomeDataState extends HomeStates{
  String error;
  ShopErrorHomeDataState(this.error);
}



class ShopLoadingCategoriesDataState extends HomeStates{}
class ShopSuccessCategoriesDataState extends HomeStates{}
class ShopErrorCategoriesDataState extends HomeStates{
  String error;
  ShopErrorCategoriesDataState(this.error);
}


class ShopSuccessChangeFavoriteState extends HomeStates{}
class ShopErrorChangeFavoriteState extends HomeStates{
  String error;
  ShopErrorChangeFavoriteState(this.error);
}

class ShopChangeFavoriteState extends HomeStates{
  final AddfavoriteModel model;

  ShopChangeFavoriteState(this.model);
}

class ShopLoadingGetFavoriteState extends HomeStates{}
class ShopSuccessGetFavoriteState extends HomeStates{}
class ShopErrorGetFavoriteState extends HomeStates{
  String error;
  ShopErrorGetFavoriteState(this.error);
}

class ShopSuccessUserDataState extends HomeStates{
  LoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}
class ShopLoadingUserDataState extends HomeStates{}
class ShopErrorUserDataState extends HomeStates{
  String error;
  ShopErrorUserDataState(this.error);
}

