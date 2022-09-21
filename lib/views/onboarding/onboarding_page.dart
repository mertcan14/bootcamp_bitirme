import 'package:bitirme_uygulamasi/views/onboarding/onboarding_welcome_page.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/onboarding/welcome');
        },
        child: Container(
          height: height-kToolbarHeight,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/pizzalogo.png", width: 100,),
                    Text("YemekBurada", style: TextStyle(fontSize: 28),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
