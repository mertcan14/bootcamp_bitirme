import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:bitirme_uygulamasi/views/auth_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingContentPage extends StatefulWidget {
  const OnboardingContentPage({Key? key}) : super(key: key);

  @override
  _OnboardingContentPageState createState() => _OnboardingContentPageState();
}

class _OnboardingContentPageState extends State<OnboardingContentPage> {
  int currentPos = 0;

  Future<void> firstOpened()async{
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("firstopen", ".");
    Navigator.pushNamed(context, '/auth');
  }

  List<CarouselModel> listCarousel=[
    CarouselModel(imgPath: "images/order1.png", title: "Kolayca Sipariş Ver", content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form"),
    CarouselModel(imgPath: "images/order2.png", title: "Kolayca Ödeme", content: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested."),
    CarouselModel(imgPath: "images/delivery.png", title: "Dakikalar İçerisinde Kapında", content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which"),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width*8.5/10,
            height: height*7/10,
            child: CarouselSlider.builder(
              itemCount: listCarousel.length,
              itemBuilder: (context,index, sayi){
                return MyImageView(content: listCarousel[index]);
              },
              options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height: height*7/10,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  }
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listCarousel.map((url) {
              int index=listCarousel.indexOf(url);
              return Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPos == index
                      ? Color.fromRGBO(0, 153, 0, 0.9)
                      : Color.fromRGBO(25, 153, 25, 0.1),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            width: width*8.5/10,
            child: ElevatedButton(
              onPressed: (){
                firstOpened();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor: mainColor
              ),
              child: Text("Başlayalım", style: TextStyle(fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }
}

class MyImageView extends StatelessWidget{

  CarouselModel content;

  MyImageView({required this.content});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height*4/10,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: width*1.4/100),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(content.imgPath)
                  ),
                ),
              )
          ),
        ),
        Text(
          content.title,
          style: TextStyle(fontSize: 28, color: mainColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          content.content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.fade,
        )
      ],
    );
  }

}

class CarouselModel{
  String imgPath;
  String content;
  String title;
  CarouselModel({required this.imgPath, required this.content, required this.title});
}
