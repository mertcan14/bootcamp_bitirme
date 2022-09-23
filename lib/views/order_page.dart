import 'package:bitirme_uygulamasi/components/myappbar.dart';
import 'package:bitirme_uygulamasi/cubit/order_cubit.dart';
import 'package:bitirme_uygulamasi/models/order_dto.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderPage extends StatefulWidget {
  String token;

  OrderPage({required this.token});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getAllOrder(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: MyAppBar(title: "Siparişlerim"),
      body: BlocBuilder<OrderCubit, List<OrderDto>>(
        builder: (context, orderDtoList){
          if(orderDtoList.isNotEmpty){
            return ListView.builder(
              itemCount: orderDtoList.length,
              itemBuilder: (context, index){
                var order = orderDtoList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Text(order.AddedDate, style: TextStyle(fontSize: 24),),
                          SizedBox(
                            height: (height*10/100) * (order.Foods.length),
                            child: ListView.builder(
                              itemCount: order.Foods.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                var food = order.Foods[index];
                                return Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height:height*8/100,
                                            width: width*2/10,
                                            child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${food.yemek_resim_adi}"),
                                          ),
                                          SizedBox(
                                            height:height*8/100,
                                            width: width*5/10,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(food.yemek_adi, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                                                Text("${food.yemek_fiyat}₺", style: TextStyle(fontSize: 16))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:height*8/100,
                                            width: width*2/10,
                                            child: Center(
                                              child: Text("${food.yemek_fiyat*int.parse(food.FoodTotal)}₺", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: height*2/100,
                                      color: mainColor,
                                      thickness: 1,
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
    );
  }
}
