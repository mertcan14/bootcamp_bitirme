import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;

  @override
  final Size preferredSize;

  MyAppBar({required this.title}): preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: textFieldColor,
      elevation: 0,
      title: Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: "RobotoMono"),),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    );
  }
}
