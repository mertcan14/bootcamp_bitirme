import 'package:bitirme_uygulamasi/models/order_food_dto.dart';

class OrderDto{
  String UserUUID;
  String AddedDate;
  List<OrderFoodDto> Foods;

  OrderDto({required this.UserUUID, required this.Foods, required this.AddedDate});
}