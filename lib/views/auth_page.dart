import 'package:bitirme_uygulamasi/views/homepage.dart';
import 'package:bitirme_uygulamasi/views/login.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:bitirme_uygulamasi/views/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../google_signin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/authpage.png", width: width*6/10,),
            Text("Şimdi Giriş Yapalım", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
            Column(
              children: [
                SizedBox(
                  width: width*9/10,
                  height: height*8/100,
                  child: ElevatedButton.icon(
                      onPressed: () async{
                        var result = await googleLoginMain();
                        result ? Navigator.pushNamed(context, "/") : null;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                      ),
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.blueAccent),
                      label: Text("Google hesabı ile giriş yap", style: TextStyle(color: Colors.black),)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height/100),
                  child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider(thickness: 1,)
                        ),
                        Text("VEYA"),
                        Expanded(
                            child: Divider(thickness: 1,)
                        ),
                      ]
                  ),
                ),
                SizedBox(
                  width: width*9/10,
                  height: height*8/100,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Email ile giriş yap"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: StadiumBorder()
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hesabınız yok mu? ", style: TextStyle(color: helperTextColor),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text("Üyelik Oluştur", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
