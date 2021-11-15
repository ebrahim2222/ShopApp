class CategoriesModel{
  bool? status;
  String? message;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json["status"];
    message = json["message"];
    data = CategoriesDataModel.fromJson(json["data"]);
  }

}


class CategoriesDataModel{

  int? current_page;
  CategoriesItemModel? data;
  List<CategoriesItemModel> itemModel=[];

  CategoriesDataModel.fromJson(Map<String , dynamic> json){
    current_page = json["current_page"];
    json["data"].forEach((element){
      itemModel.add(CategoriesItemModel.fromJson(element));
    });
  }


}

class CategoriesItemModel{
  int? id;
  String? name;
  String? image;

  CategoriesItemModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
