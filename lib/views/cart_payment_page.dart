import 'package:bitirme_uygulamasi/components/myappbar.dart';
import 'package:bitirme_uygulamasi/cubit/cart_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/order_cubit.dart';
import 'package:bitirme_uygulamasi/models/sepet_yemekler.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPaymentPage extends StatefulWidget {
  List<SepetYemekler> yemekler;
  int total_price;

  CartPaymentPage({required this.yemekler, required this.total_price});

  @override
  _CartPaymentPageState createState() => _CartPaymentPageState();
}

class _CartPaymentPageState extends State<CartPaymentPage> {
  var kart_number_controller = TextEditingController();
  var selected_value_months = "9";
  var selected_value_years = "2022";
  var cvv_controller = TextEditingController();

  List<DropdownMenuItem<String>> months = [
    DropdownMenuItem(child: Text("Ocak"),value: "1"),
    DropdownMenuItem(child: Text("Şubat"),value: "2"),
    DropdownMenuItem(child: Text("Mart"),value: "3"),
    DropdownMenuItem(child: Text("Nisan"),value: "4"),
    DropdownMenuItem(child: Text("Mayıs"),value: "5"),
    DropdownMenuItem(child: Text("Haziran"),value: "6"),
    DropdownMenuItem(child: Text("Temmuz"),value: "7"),
    DropdownMenuItem(child: Text("Ağustos"),value: "8"),
    DropdownMenuItem(child: Text("Eylül"),value: "9"),
    DropdownMenuItem(child: Text("Ekim"),value: "10"),
    DropdownMenuItem(child: Text("Kasım"),value: "11"),
    DropdownMenuItem(child: Text("Aralık"),value: "12"),
  ];
  List<DropdownMenuItem<String>> years = [
    DropdownMenuItem(child: Text("2022"),value: "2022"),
    DropdownMenuItem(child: Text("2023"),value: "2023"),
    DropdownMenuItem(child: Text("2024"),value: "2024"),
    DropdownMenuItem(child: Text("2025"),value: "2025"),
    DropdownMenuItem(child: Text("2026"),value: "2026"),
    DropdownMenuItem(child: Text("2027"),value: "2027"),
    DropdownMenuItem(child: Text("2028"),value: "2028"),
    DropdownMenuItem(child: Text("2029"),value: "2029"),
    DropdownMenuItem(child: Text("2030"),value: "2030"),
    DropdownMenuItem(child: Text("2031"),value: "2031"),
    DropdownMenuItem(child: Text("2032"),value: "2032"),
    DropdownMenuItem(child: Text("2033"),value: "2033"),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: textFieldColor,
      appBar: MyAppBar(title: "Güvenli Ödeme"),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
            height: height - kToolbarHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*2/100),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width*2/100, vertical: height/100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kart Bilgileri", style: TextStyle(fontSize: 20, fontFamily: "Lora"),),
                          Divider(
                            height: height/100,
                            thickness: 0.7,
                          ),
                          Text("Kart Numarası", style: TextStyle(fontSize: 16),),
                          SizedBox(
                            height: height*5/100,
                            child: TextField(
                              controller: kart_number_controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:const EdgeInsets.all(5.0),
                                filled: true,
                                fillColor: textFieldColor,
                                hintText: "**** **** **** ****",
                                hintStyle: TextStyle(
                                  wordSpacing: 2.0,
                                  fontSize: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: textFieldColor), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: textFieldColor), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height*2/100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width*5/10,
                                  child: Column(
                                    children: [
                                      Align(alignment: Alignment.centerLeft,child: Text("Son Kullanma Tarihi",  style: TextStyle(fontSize: 16))),
                                      Row(
                                        children: [
                                          DropdownButton(
                                            items: months,
                                            menuMaxHeight: 150,
                                            hint: Text(
                                              "Ay",
                                              style: TextStyle(color: Colors.grey),
                                              textAlign: TextAlign.end,
                                            ),
                                            value: selected_value_months,
                                            onChanged: (value){
                                              setState(() {
                                                selected_value_months = value.toString();
                                              });
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left:width*2/100),
                                            child: DropdownButton(
                                              items: years,
                                              menuMaxHeight: 150,
                                              hint: Text(
                                                "Yıl",
                                                style: TextStyle(color: Colors.grey),
                                                textAlign: TextAlign.end,
                                              ),
                                              value: selected_value_years,
                                              onChanged: (value){
                                                setState(() {
                                                  selected_value_years = value.toString();
                                                });
                                              },

                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width*2/10,
                                  child: Column(
                                    children: [
                                      Align(alignment: Alignment.centerLeft,child: Text("CVV", style: TextStyle(fontSize: 16))),
                                      SizedBox(
                                        height: height*5/100,
                                        child: TextField(
                                          controller: cvv_controller,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:const EdgeInsets.all(5.0),
                                            filled: true,
                                            fillColor: textFieldColor,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: textFieldColor), //<-- SEE HERE
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: textFieldColor), //<-- SEE HERE
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height*13/100,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: height*2/100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Toplam", style: TextStyle(fontSize: 18),),
                            Text("${widget.total_price}₺", style: TextStyle(fontSize: 18))
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: height*2/100, horizontal: width*3/100),
                              backgroundColor: mainColor,
                              shape: StadiumBorder()
                          ),
                          onPressed: () async{
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            var token = await sharedPreferences.getString("token") ?? "";
                            await context.read<OrderCubit>().addOrder(token, widget.yemekler);
                            await context.read<CartCubit>().cartDeleteAllByEmail();
                            Navigator.pushNamed(context, "/");
                          },
                          child: Text("Onayla ve Bitir", style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
