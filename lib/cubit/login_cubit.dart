import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
class LoginScreenCubit extends Cubit<ShopStates>{
  LoginScreenCubit():super(InitialShopStates());

  static LoginScreenCubit get(context){
    return BlocProvider.of(context);
  }

  void userLogin(String email, String pass){
    LoginModel model;
    emit(shopLoginLoadingState());
    DioHelper.postData(path: "login",data: {
      "email" : "$email",
      "password" : "$pass"
    }).then((value) {
      model = LoginModel.fromJson(value.data);
      emit(shopLoginSuccessState(model));
    }).catchError((error){
      emit(shopLoginErrorState(error));
      print(error);
    });
  }
}
