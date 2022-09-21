import 'dart:convert';
import 'package:bitirme_uygulamasi/models/sepet_yemekler.dart';
import 'package:bitirme_uygulamasi/models/sepet_yemekler_result.dart';
import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:bitirme_uygulamasi/models/yemekler_result.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository{

  var url = "http://kasimadalan.pe.hu/yemekler/";

  List<Yemekler> yemeklerResultParse(String result){
    return YemeklerResult.fromJson(json.decode(result)).yemekler;
  }

  List<SepetYemekler> sepetYemeklerResultParse(String result){
    try{
      return SepetYemeklerResult.fromJson(json.decode(result)).sepet_yemekler;
    }catch(e){
      print(e);
      List<SepetYemekler> sepetYemekler = [];
      return sepetYemekler;
    }
  }

  Future<List<Yemekler>> getAllYemekler() async{
    var newUrl = url + "tumYemekleriGetir.php";
    var result = await Dio().get(newUrl);
    return yemeklerResultParse(result.data.toString());
  }

  Future<List<SepetYemekler>> getAllCart(String email) async{
    var newUrl = url + "sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":email};
    var result = await Dio().post(newUrl, data: FormData.fromMap(veri));
    return sepetYemeklerResultParse(result.data.toString());
  }

  Future<void> deleteCart(String email, int sepet_yemek_id) async{
    var newUrl = url + "sepettenYemekSil.php";
    var veri = {"kullanici_adi":email, "sepet_yemek_id":sepet_yemek_id};
    var result = await Dio().post(newUrl, data: FormData.fromMap(veri));
  }

  Future<void> addYemekCart(Yemekler yemek, String email) async{
    var newUrl = url + "sepeteYemekEkle.php";
    var veri = {"yemek_adi":yemek.yemek_adi, "yemek_resim_adi": yemek.yemek_resim_adi,
    "yemek_fiyat": yemek.yemek_fiyat, "yemek_siparis_adet":1,
    "kullanici_adi": email};
    await Dio().post(newUrl, data: FormData.fromMap(veri));
  }

  Future<void> addYemekCartWithTotal(Yemekler yemek, String email, int total) async{
    var newUrl = url + "sepeteYemekEkle.php";
    var veri = {"yemek_adi":yemek.yemek_adi, "yemek_resim_adi": yemek.yemek_resim_adi,
      "yemek_fiyat": yemek.yemek_fiyat, "yemek_siparis_adet":total,
      "kullanici_adi": email};
    await Dio().post(newUrl, data: FormData.fromMap(veri));
  }
}