class ChangeFavoriteModel {
  bool status =false;
  String message ='';
  ChangeFavoriteModel.fromjson(Map<String, dynamic> json){
    status =json['status'];
    message =json['message'];
  }
}