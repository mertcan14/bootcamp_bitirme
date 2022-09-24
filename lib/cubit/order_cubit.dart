import 'package:bitirme_uygulamasi/models/order.dart';
import 'package:bitirme_uygulamasi/models/order_dto.dart';
import 'package:bitirme_uygulamasi/models/order_food_dto.dart';
import 'package:bitirme_uygulamasi/models/sepet_yemekler.dart';
import 'package:bitirme_uygulamasi/repo/yemekler_dao_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderCubit extends Cubit<List<OrderDto>>{
  OrderCubit():super(<OrderDto>[]);

  var refOrder = FirebaseFirestore.instance.collection("Order");
  var yRepo = YemeklerDaoRepository();
  final date_format = new DateFormat('yyyy.MM.dd hh:mm');

  Future<void> getAllOrder(String token) async{
    List<Order> orderList = [];
    List<OrderDto> orderDtos = [];
    var yemekList = await yRepo.getAllYemekler();
    await refOrder.where("UserUUID", isEqualTo: token).get().then((snapshot) {
      if(snapshot != null){
        for(var order in snapshot.docs){
          orderList.add(Order.fromJson(order.data()));
        }
      }
    });
    if(orderList.isNotEmpty){
      orderList.forEach((order){
        List<OrderFoodDto> orderFoodDto = [];
        order.Foods.forEach((food) async{
          var yemek = yemekList.firstWhere((element) => element.yemek_id.toString() == food.FoodId  );
          orderFoodDto.add(new OrderFoodDto(FoodId: food.FoodId, FoodTotal: food.FoodTotal,
              yemek_adi: yemek.yemek_adi, yemek_fiyat: yemek.yemek_fiyat, yemek_resim_adi: yemek.yemek_resim_adi));
        });
        orderDtos.add(new OrderDto(UserUUID: order.UserUUID, Foods: orderFoodDto, AddedDate: order.AddedDate));
      });
    }
    emit(orderDtos);
  }

  Future<void> addOrder(String token, List<SepetYemekler> sepetList) async{
    List itemList = [];
    sepetList.forEach((sepet) {
      itemList.add({
        "FoodId":sepet.yemek_id.toString(),
        "FoodTotal": sepet.yemek_siparis_adet.toString(),
      });
    });
    await refOrder.doc().set({"Foods":FieldValue.arrayUnion(itemList), "AddedDate": date_format.format(DateTime.now()).toString(), "UserUUID": token});

  }
}