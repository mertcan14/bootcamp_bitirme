import 'package:bitirme_uygulamasi/components/myappbar.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';

class AddAddressPage extends StatefulWidget {
  String token;
  String address_length;

  AddAddressPage({required this.token, required this.address_length});

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  var addressTitleController = TextEditingController();
  var cityController = TextEditingController();
  var districtController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: MyAppBar(title: "Adres Ekle"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*3/100, vertical: height*5/100),
          child: SizedBox(
            height: height-kToolbarHeight - padding.top - (height/10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: addressTitleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "Adres Başlık",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.title, color: mainColor),
                  ),
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "Şehir",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.location_city, color: mainColor),
                  ),
                ),
                TextField(
                  controller: districtController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "İlçe",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.home_work, color: mainColor),
                  ),
                ),
                TextField(
                  controller: addressController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "Açık Adres",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.home_work, color: mainColor),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height*8/100,
                  child: ElevatedButton.icon(
                    onPressed: (){

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: StadiumBorder()
                    ),
                    icon: Icon(Icons.add, size: 28,),
                    label: Text("Adres Ekle", style: TextStyle(fontSize: 18),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
