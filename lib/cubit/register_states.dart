import 'package:shop_app/model/login_model.dart';

abstract class RegisterStates{}

class InitializedRegisterState extends RegisterStates{}

class LoadingRegisterState extends RegisterStates{}

class SuccessRegisterState extends RegisterStates{
  LoginModel loginModel;
  SuccessRegisterState(this.loginModel);
}

class ErrorRegisterState extends RegisterStates{
  String error;
  ErrorRegisterState(this.error);
}