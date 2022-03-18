class CategoriesModel {
  bool status=false;
  CategoriesData? data ;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  int currentPage=0;
  List<ProductDataOfCategory> data=[];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(ProductDataOfCategory.fromJson(element));
      });
    }
  }
}

class ProductDataOfCategory {
  int id =0;
  String name='';
  String image='';

  ProductDataOfCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
