import 'package:bitirme_uygulamasi/components/bottom_navigation_bar_custom.dart';
import 'package:bitirme_uygulamasi/cubit/category_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/homepage_cubit.dart';
import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:bitirme_uygulamasi/views/category_page.dart';
import 'package:bitirme_uygulamasi/views/detail_yemek_page.dart';
import 'package:bitirme_uygulamasi/views/my_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  var searchController = TextEditingController();
  var email;
  var token;
  var photoUrl;
  bool dataLoaded = false;

  @override
  void initState(){
    super.initState();
    getUser();
    context.read<HomepageCubit>().yemeklerGetAll();
    context.read<CategoryCubit>().getAllCategory();
  }

  Future<void> getUser() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    var first_open = await sharedPreferences.getString("firstopen");
    if(first_open == null){
      await Navigator.pushReplacementNamed(context, "/onboarding");
    }
    email = await sharedPreferences.getString("email");
    if(email == null){
      await Navigator.pushReplacementNamed(context, "/auth");
    }
    token = await sharedPreferences.getString("token");
    photoUrl = await sharedPreferences.getString("photo");
    setState(() {
      dataLoaded = true;
    });
  }
  void searchData(String query) async{
    context.read<HomepageCubit>().yemeklerSearch(searchController.text);
  }

  Future<void> signOut() async{
    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove("email");
      sharedPreferences.remove("token");
      sharedPreferences.remove("photo");
      Navigator.pushReplacementNamed(context, "/");
    } catch (e) {
      print("hata");
    }
  }

  void detailYemek(Yemekler yemekler){
    showDialog(
      context: context,
      builder: (ctx)=>AlertDialog(
        content: DetailYemekPage(yemekler: yemekler),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: textFieldColor,
      bottomNavigationBar: BottomNavigationBarCustom(secili_sayfa: 0,),
      body: dataLoaded ? SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: (padding.top+height/100), horizontal: width*3/100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width*1.3/10,
                        height: height*0.9/10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: photoUrl != null ? Image.network(photoUrl, fit: BoxFit.fill) : Image.asset(
                            'images/man.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*2/100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bugün Canınız Ne Çekiyor ?", style: TextStyle(color: helperTextColor),),
                            Text(email == null ? "" : email, style: TextStyle(color: Colors.black),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: helperTextColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          highlightColor: Colors.white,
                          onPressed: (){
                            Navigator.pushNamed(context, "/cart");
                          },
                          icon: Icon(Icons.shopping_bag),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width/100),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: helperTextColor, width: 1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            highlightColor: Colors.white,
                            onPressed: (){
                              signOut();
                            },
                            icon: Icon(Icons.exit_to_app),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: height*2/100),
                child: TextField(
                  onChanged: searchData,
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: mainColor,),
                    hintText: "Ne Arıyorsunuz ?",
                    filled: true,
                    fillColor: textFieldColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: textFieldColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: height*1.5/100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Kategoriler", style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height*1.5/10,
                child: CategoryPage()
              ),
              Padding(
                padding: EdgeInsets.only(top: height/100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:const Text("Yemekler :D", style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height*6/10,
                child:BlocBuilder<HomepageCubit, List<Yemekler>>(
                  builder: (context, yemeklerList){
                    if(yemeklerList.isNotEmpty){
                      return ListView.builder(
                        itemCount: yemeklerList.length,
                        itemBuilder: (context, index){
                          var yemek = yemeklerList[index];
                          return GestureDetector(
                            onTap: (){
                              detailYemek(yemek);
                            },
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
                                            width: width*2.2/10,
                                            height: height*1.2/10,
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
                                                  Text("  ${yemek.yemek_fiyat}₺", style: TextStyle(
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
                                        padding: EdgeInsets.only(right: width*3/100),
                                        child: IconButton(
                                          onPressed: (){
                                            context.read<HomepageCubit>().yemekCartAdd(yemek, email);
                                          },
                                          icon: Icon(Icons.add_shopping_cart, color: mainColor, size: 34),
                                          style: IconButton.styleFrom(
                                              backgroundColor: mainColor
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }else{
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/sadface.png"),
                          Padding(
                            padding: EdgeInsets.only(top: height*2/100),
                            child: Text("Üzgünüz Yemek Bulunamadı...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          )
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ) : Column(children: [],),
    );
  }
}

