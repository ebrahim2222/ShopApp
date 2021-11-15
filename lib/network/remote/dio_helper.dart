import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio;

  static void init(){
    dio = Dio(
      BaseOptions(
        baseUrl:"https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      )
    );
  }
  
  static Future<Response> postData({String? path , Map<String ,dynamic>? data})async{
    return await dio!.post(path!,
      data: data
    );
  }



  static Future<Response> getData({
    required path,
    Map<String,dynamic>? query,
    String lang="en",
    String? token

  })async{
    dio!.options.headers ={
      "Content-Type":"application/json",
      "Authorization" :token,
      "lang":lang
    };
   return await dio!.get(path,queryParameters: query);
  }

  static Future<Response> changeFavorite({
    required String? path,
    required int? id,
    required String? token,
    String lang="en",

  }){
    dio!.options.headers ={
      "Content-Type":"application/json",
      "Authorization" :token,
      "lang":lang
    };
    return DioHelper.postData(
        path: path,
        data: {
          "product_id":id
        }
    );
  }



}