import 'package:bitirme_uygulamasi/models/order_food.dart';

class Order{
  String UserUUID;
  String AddedDate;
  List<OrderFood> Foods;

  Order({required this.UserUUID, required this.Foods, required this.AddedDate});

  factory Order.fromJson(Map<dynamic, dynamic> json){
    var foods = json["Foods"] as List;
    print("asdasd");
    return Order(UserUUID: json["UserUUID"] as String, Foods: foods.map((e) => OrderFood.fromJson(e)).toList(),
    AddedDate: json["AddedDate"] as String);
  }
}