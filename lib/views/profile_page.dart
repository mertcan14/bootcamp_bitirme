import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottom_navigation_bar_custom.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var email;
  var token;
  var photoUrl;
  bool dataLoaded = false;


  Future<void> getUser() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    email = await sharedPreferences.getString("email");
    if(email == null){
      await Navigator.pushReplacementNamed(context, "/auth");
    }
    photoUrl = await sharedPreferences.getString("photo");
    token = await sharedPreferences.getString("token");
    setState(() {
      dataLoaded = true;
    });
  }
  List<Map<String, dynamic>> profileList =[
    {"title": "Adreslerim", "icon":Icons.location_on, "color": Color(0xff80ed99), "url": "/address"},
    {"title": "Siparişlerim", "icon":Icons.note_rounded, "color": Color(0xffab4e68),"url": "/orders"},
    {"title": "Favorilerim", "icon":Icons.favorite_border, "color": Color(0xff34a0a4)},
    {"title": "Çıkış", "icon":Icons.logout, "color": Color(0xff6a040f)},
  ];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: textFieldColor,
      bottomNavigationBar: BottomNavigationBarCustom(secili_sayfa: 2,),
      body: dataLoaded ? Padding(
        padding: EdgeInsets.only(top: kToolbarHeight, left: width*3/100, right: width*3/100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width*3/10,
              height: height*2/10,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: photoUrl != null ? Image.network(photoUrl, fit: BoxFit.fill) : Image.asset(
                  'images/man.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(email??"", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),),
            SizedBox(
              width: width,
              height: height*4.5/10,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/1,
                ),
                itemCount: profileList.length,
                itemBuilder: (context, index){
                  var data = profileList[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, data["url"], arguments: token);
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(data["title"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Icon(data["icon"], color: data["color"], size: 30,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ) : Center(
          child: CircularProgressIndicator(color: mainColor)
      ),
    );
  }
}
