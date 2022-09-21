import 'package:bitirme_uygulamasi/views/my_color.dart';
import 'package:bitirme_uygulamasi/views/onboarding/onboarding_content_page.dart';
import 'package:flutter/material.dart';

class OnboardingWelcomPage extends StatefulWidget {
  const OnboardingWelcomPage({Key? key}) : super(key: key);

  @override
  _OnboardingWelcomPageState createState() => _OnboardingWelcomPageState();
}

class _OnboardingWelcomPageState extends State<OnboardingWelcomPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width= size.width;
    var heigt = size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/onboarding/content');
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/foodphoto.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: width*3/100, right: width*3/100, bottom: heigt*2/100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Hoşgeldiniz YemekBurada'ya",
                  style: TextStyle(fontSize: 35, color: mainColor, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ",
                  style: TextStyle(color: Colors.white, fontSize: 16,),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
