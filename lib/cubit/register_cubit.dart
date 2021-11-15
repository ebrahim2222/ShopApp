import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/register_states.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(InitializedRegisterState());

  static RegisterCubit get(context){
    return BlocProvider.of(context);
  }
  LoginModel? loginModel;
  void register({path,name , email , phone,pass}){
    emit(LoadingRegisterState());
   DioHelper.postData(path: path, data: {
     "name":name,
     "phone":phone,
     "email":email,
     "password":pass
   }).then((value) {
     print(value.data);
     loginModel = LoginModel.fromJson(value.data);
     emit(SuccessRegisterState(loginModel!));
   }).catchError((error){
     print(error);
     emit(ErrorRegisterState(error));
   });
}

}