class FavModel {
  bool status = false;
  String message = '';
  Data? data;

  FavModel(this.status, this.message, this.data);

  FavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int currentPage = 0;
  List<detailsData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(detailsData.fromJson(element));
      });
    }
  }
}

class detailsData {
  int? id;
  Product? product;
  detailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int id = 0;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product(this.id, this.price, this.oldPrice, this.discount, this.image);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
