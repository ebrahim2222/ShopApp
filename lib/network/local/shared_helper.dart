import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedPreferences? preferences;
  static init()async{
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putOnBoardingValue({bool? value})async{
    return await preferences!.setBool("onBoardingValue", value!);
  }

  static bool? getOnBoardingValue(){
    return  preferences!.getBool("onBoardingValue");
  }

  static Future<bool> saveToken({value})async{
    return await preferences!.setString("token", value);
  }


  static String? getToken(){
    return  preferences!.getString("token");
  }

  static void removToken(){
    preferences!.remove("token");
  }
}