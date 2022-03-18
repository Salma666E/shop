class SearchModel {
  bool status = false;
  String message = '';
  Data? data;

  SearchModel(this.status, this.message, this.data);

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int currentPage = 0;
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(Product.fromJson(element));
      });
    }
  }
}

class Product {
  int id = 0;
  dynamic price;
  String? image;
  String? name;
  String? description;

  Product(this.id, this.price, this.image);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
