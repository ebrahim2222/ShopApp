import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_states.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/cateories_model.dart';
import 'package:shop_app/model/favoirite_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/model/shop_get_favorite.dart';
import 'package:shop_app/network/local/shared_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/ui/screens/category_screen.dart';
import 'package:shop_app/ui/screens/favorite_screen.dart';
import 'package:shop_app/ui/screens/home_screen.dart';
import 'package:shop_app/ui/screens/product_screen.dart';
import 'package:shop_app/ui/screens/setting_screen.dart';
import 'package:flutter/material.dart';


class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());

  static HomeCubit get(context){
    return BlocProvider.of(context);
  }
  HomeModel? model;
  CategoriesModel? categoriesModel;
  Map<dynamic,dynamic> favoriteList ={};

  List<Widget> screensWidget =[
    ProductsScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];

  List<BottomNavigationBarItem> items =[
     BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,), label: "products"),
     BottomNavigationBarItem(icon: Icon(Icons.category,color: Colors.black,), label: "Category"),
     BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.black), label: "favorites"),
     BottomNavigationBarItem(icon: Icon(Icons.settings,color: Colors.black), label: "settings"),
  ];

  int currentIndex = 0;
  void changeNavBarIndex(int index){
    currentIndex = index;
    emit(HomeBottomNav());
  }

  void getData({String? path}){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(path: path!,token: SharedHelper.getToken()).then((value) {
      model = HomeModel.fromJson(value.data);

      model!.data!.products.forEach((element) {
        favoriteList.addAll({
          element.id! : element.in_favorites!
        });
      });

      print(favoriteList.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      emit(ShopErrorHomeDataState(error));
    });
  }


  void getCategoryData({String? path}){

    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(path: path!).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      emit(ShopErrorCategoriesDataState(error));
    });
  }
  late AddfavoriteModel addfavoriteModel;
  void changeFavorite({path,id, token}){
    favoriteList[id] = !favoriteList[id];
    emit(ShopSuccessChangeFavoriteState());
    DioHelper.changeFavorite(
      path: path,
      id: id,
      token: token
    ).then((value) {
      emit(ShopSuccessChangeFavoriteState());
      addfavoriteModel = AddfavoriteModel.fromJson(value.data);
      if(!addfavoriteModel.status){
        favoriteList[id] = !favoriteList[id];
      }else{
        getFavorite(token: SharedHelper.getToken());

      }
    }).catchError((error){
      favoriteList[id] = !favoriteList[id];
      emit(ShopErrorChangeFavoriteState(error));
    });
  }
  ShopGetFavoriteModel? getFavoriteModel;
  void getFavorite({String? token}){
    DioHelper.getData(path: "favorites",token: token).then((value) {
      getFavoriteModel = ShopGetFavoriteModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoriteState(error));

    });
  }
  LoginModel? loginModel;
  void getUserData({path , token}){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(path:path , token: token ).then((value)  {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(loginModel!));
    }).catchError((error){
      print(error.toString);
      emit(ShopErrorUserDataState(error));
    });
  }
}