import '/models/home_mdl.dart';

class SingleCategoryModel {
  bool status = false;
  String message = '';
  Data? data;

  SingleCategoryModel(this.status, this.message, this.data);

  SingleCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int currentPage = 0;
  List<ProductModel> data = [];
  String firstPageUrl = '';
  int from = 0;
  int lastPage = 0;
  String lastPageUrl = '';
  Null nextPageUrl;
  String path = '';
  int perPage = 0;
  Null prevPageUrl;
  int to = 0;
  int total = 0;

  Data(
      this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total);

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(ProductModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['current_page'] = this.currentPage;
  //   if (this.data != null) {
  //     data['data'] = this.data.map((v) => v.toJson()).toList();
  //   }
  //   data['first_page_url'] = this.firstPageUrl;
  //   data['from'] = this.from;
  //   data['last_page'] = this.lastPage;
  //   data['last_page_url'] = this.lastPageUrl;
  //   data['next_page_url'] = this.nextPageUrl;
  //   data['path'] = this.path;
  //   data['per_page'] = this.perPage;
  //   data['prev_page_url'] = this.prevPageUrl;
  //   data['to'] = this.to;
  //   data['total'] = this.total;
  //   return data;
  // }
}
