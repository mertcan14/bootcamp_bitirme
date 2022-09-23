class OrderFoodDto{
  String FoodId;
  String FoodTotal;
  String yemek_adi;
  String yemek_resim_adi;
  int yemek_fiyat;

  OrderFoodDto({required this.FoodId, required this.FoodTotal, required this.yemek_adi, required this.yemek_fiyat, required this.yemek_resim_adi});
}