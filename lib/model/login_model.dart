class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String,dynamic> json){
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? UserData.fromJson(json["data"]) : null;
  }

}

class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  String?token;

  UserData({this.id, this.name, this.email, this.phone, this.image, this.points,
      this.token});
  UserData.fromJson(Map<String , dynamic> json){
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    token = json["token"];
  }
}