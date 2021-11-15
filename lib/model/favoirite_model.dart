class AddfavoriteModel{
  late bool status;
  String? message;

  AddfavoriteModel.fromJson(Map<String , dynamic> json){
    status = json["status"];
    message = json["message"];
  }
}