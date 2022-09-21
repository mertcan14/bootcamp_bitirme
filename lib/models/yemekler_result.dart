import 'package:bitirme_uygulamasi/models/yemekler.dart';

class YemeklerResult{
  List<Yemekler> yemekler;
  int success;

  YemeklerResult({required this.yemekler, required this.success});

  factory YemeklerResult.fromJson(Map<String, dynamic> json){
    var jsonArray = json["yemekler"] as List;
    List<Yemekler> yemekler = jsonArray.map((e) => Yemekler.fromJson(e)).toList();
    return YemeklerResult(yemekler: yemekler, success: json["success"] as int);
  }
}