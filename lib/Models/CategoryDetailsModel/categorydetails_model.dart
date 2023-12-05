import '../Home/home_model.dart';

class CategoryDetailsModel {
  bool? status;
  dynamic message;
  Data? data;


  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {

  List<Products>? products;


  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      products = <Products>[];
      json['data'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }
}

