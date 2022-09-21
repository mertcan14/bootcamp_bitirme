import 'package:bitirme_uygulamasi/components/bottom_navigation_bar_custom.dart';
import 'package:bitirme_uygulamasi/cubit/cart_cubit.dart';
import 'package:bitirme_uygulamasi/models/sepet_yemekler.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_uygulamasi/views/my_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var totalPrice = 0;
  SlidableController? _slidableController;

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Future<void> getCart() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("email");
    if(email != null){
      context.read<CartCubit>().cartGetAllByEmail(email);
    }
  }

  void calcuTotalPrice(List<SepetYemekler> yemekler){
    totalPrice = 0;
    for(var yemek in yemekler){
      totalPrice += yemek.yemek_siparis_adet*yemek.yemek_fiyat;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: Color(0xff9ae19d),
      bottomNavigationBar: BottomNavigationBarCustom(secili_sayfa: 1,),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Sepetim", style: TextStyle(color: Colors.black, fontSize: 24),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        actions: [
          IconButton(
            onPressed: () async{
              await context.read<CartCubit>().cartDeleteAllByEmail();
            },
            icon: Icon(Icons.delete, color: Colors.red,),
          )
        ],
      ),
      body: BlocBuilder<CartCubit, List<SepetYemekler>>(
        builder: (context, sepetYemekler){
          if(sepetYemekler.isNotEmpty){
            calcuTotalPrice(sepetYemekler);
            return Column(
              children: [
                Container(
                  height: height*6.5/10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric( horizontal: width*3/100),
                    child: ListView.builder(
                      itemCount: sepetYemekler.length,
                      itemBuilder: (context, index){
                        var yemek = sepetYemekler[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context){
                                  context.read<CartCubit>().cartDeleteByEmailYemekname(yemek.yemek_adi);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                icon: Icons.delete,
                                label: 'Sil',
                              ),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          width: width*2/10,
                                          height: height*1/10,
                                          decoration: BoxDecoration(
                                              color: textFieldColor,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height*1.2/10,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(yemek.yemek_adi, style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                FaIcon(FontAwesomeIcons.motorcycle, color: mainColor),
                                                Text("  ${yemek.yemek_fiyat * yemek.yemek_siparis_adet}₺", style: TextStyle(
                                                  fontSize: 20,
                                                ),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: width*2/100),
                                    child: Text("${yemek.yemek_siparis_adet}", style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor  ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric( horizontal: width*3/100),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Toplam Tutar: ", style: TextStyle(fontSize: 20),),
                            Text("${totalPrice}£", style: TextStyle(fontSize: 20))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Toplam İndirim: ", style: TextStyle(fontSize: 20),),
                            Text("0£", style: TextStyle(fontSize: 20))
                          ],
                        ),
                        Divider(thickness: 1.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Toplam Ödenecek Tutar: ", style: TextStyle(fontSize: 22),),
                            Text("${totalPrice}£", style: TextStyle(fontSize: 22))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }else{
            return Container(
              width: width,
              height: height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/empty.png"),
                  Padding(
                    padding: EdgeInsets.only(top: height/10),
                    child: Text("Sepetiniz Boş", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  ),
                  Text("Sepetinizde ürün bulunamamıştır", style: TextStyle(
                      color: helperTextColor,
                      fontSize: 18
                  ),),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
