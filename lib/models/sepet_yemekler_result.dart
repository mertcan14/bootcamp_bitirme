import 'package:bitirme_uygulamasi/models/sepet_yemekler.dart';

class SepetYemeklerResult{
  List<SepetYemekler> sepet_yemekler;
  int success;

  SepetYemeklerResult({required this.sepet_yemekler, required this.success});

  factory SepetYemeklerResult.fromJson(Map<String, dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    List<SepetYemekler> sepetYemekler = jsonArray.map((e) => SepetYemekler.fromJson(e)).toList();
    return SepetYemeklerResult(sepet_yemekler: sepetYemekler, success: json["success"] as int);
  }
}