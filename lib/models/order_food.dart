class OrderFood{
  String FoodId;
  String FoodTotal;


  OrderFood({required this.FoodId, required this.FoodTotal});

  factory OrderFood.fromJson(Map<dynamic, dynamic> json){
    return OrderFood(FoodId: json["FoodId"] as String, FoodTotal: json["FoodTotal"] as String);
  }
}