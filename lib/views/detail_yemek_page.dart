import 'package:bitirme_uygulamasi/components/myappbar.dart';
import 'package:bitirme_uygulamasi/cubit/detailyemek_cubit.dart';
import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailYemekPage extends StatefulWidget {
  final Yemekler yemekler;

  DetailYemekPage({required this.yemekler});

  @override
  _DetailYemekPageState createState() => _DetailYemekPageState();
}

class _DetailYemekPageState extends State<DetailYemekPage> {
  num _defaultValue = 1;

  Future<void> addCart(Yemekler yemek, int total) async{
    var sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("email");
    if(email != null) {
      await context.read<DetailYemekCubit>().yemekCartAddWithTotal(yemek, email, total);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: textFieldColor,
      appBar: MyAppBar(title: "Yemek",),
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemekler.yemek_resim_adi}"),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(widget.yemekler.yemek_adi, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                ),
                Text("${widget.yemekler.yemek_fiyat}₺", style: TextStyle(fontSize: 24),),
              ],
            ),
            Column(
              children: [
                ElegantNumberButton(
                  initialValue: _defaultValue,
                  color: mainColor,
                  buttonSizeWidth: 50,
                  buttonSizeHeight: 30,
                  textStyle: TextStyle(fontSize: 24),
                  minValue: 1,
                  maxValue: 20,
                  step: 1,
                  decimalPlaces: 0,
                  onChanged: (value) { // get the latest value from here
                    setState(() {
                      _defaultValue = value;
                    });
                  },
                ),
                Padding(
                  padding:const EdgeInsets.only(top: 10.0),
                  child: Text("Toplam Ücret: ${widget.yemekler.yemek_fiyat * _defaultValue}₺", style: TextStyle(fontSize: 16),),
                )
              ],
            ),
            ElevatedButton.icon(
              onPressed: (){
                addCart(widget.yemekler, _defaultValue.toInt());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0)
              ),
              icon: Icon(Icons.add_shopping_cart),
              label: Text("Sepete Ekle", style: TextStyle(fontSize: 18),),
            )
          ],
        ),
      ),
    );
  }
}
