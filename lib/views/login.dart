import 'package:bitirme_uygulamasi/google_signin.dart';
import 'package:bitirme_uygulamasi/views/homepage.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> login(String email, String password) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((user) async{
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("email", user.user!.email ?? "");
      sharedPreferences.setString("token", user.user!.uid ?? "");
    });
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Giriş Yapın"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width/20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Giriş Yap", style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: height*4/100),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textFieldColor,
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    hintText: "Şifre",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: width*9/10,
                  height: height*8/100,
                  child: ElevatedButton(
                    onPressed: () async{
                      await login(emailController.text, passwordController.text);
                      Navigator.pushReplacementNamed(context, "/");
                    },
                    child: Text("Giriş Yap"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: StadiumBorder()
                    ),
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
                  child: ElevatedButton.icon(
                      onPressed: () async{
                        var result = await googleLoginMain();
                        result ? Navigator.pushReplacementNamed(context, "/") : null;
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                      ),
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.blueAccent),
                      label: Text("Google hesabı ile giriş yap", style: TextStyle(color: Colors.black),)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
