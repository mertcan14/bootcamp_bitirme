import 'package:bitirme_uygulamasi/views/cart_page.dart';
import 'package:bitirme_uygulamasi/views/homepage.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:bitirme_uygulamasi/views/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  final int secili_sayfa;

  BottomNavigationBarCustom({required this.secili_sayfa});

  @override
  _BottomNavigationBarCustomState createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int secili_sayfa = 0;
  List<Widget> _children = [];


  void routesPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>_children[secili_sayfa]));
  }


  @override
  void initState() {
    secili_sayfa = widget.secili_sayfa;
    _children = [
      Homepage(),
      CartPage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      /*borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0)
      ),*/
      child: BottomNavigationBar(
        elevation: 16.0,
        backgroundColor: Colors.white,
        currentIndex: secili_sayfa,
        onTap:(index) async{
          secili_sayfa = await index;
          routesPage();
        },
        selectedLabelStyle: TextStyle(fontSize: 18, fontFamily: "Lobster"),
        selectedItemColor: mainColor,
        selectedIconTheme: IconThemeData(
          color: mainColor,
          size: 32
        ),
        unselectedLabelStyle: TextStyle(fontFamily: "Lora"),
        unselectedItemColor: helperTextColor,
        unselectedIconTheme: IconThemeData(
          color: helperTextColor
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Ana Sayfa"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Sepet"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil"
          ),
        ],
      ),
    );
  }
}
