class SepetYemekler{
  int sepet_yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  int yemek_fiyat;
  int yemek_siparis_adet;
  String kullanici_adi;
  String? yemek_id;

  SepetYemekler({required this.sepet_yemek_id, required this.yemek_adi, required this.yemek_siparis_adet,
  required this.yemek_resim_adi, required this.yemek_fiyat, required this.kullanici_adi});

  factory SepetYemekler.fromJson(Map<String, dynamic> json){
    return SepetYemekler(sepet_yemek_id: int.parse(json["sepet_yemek_id"]), yemek_adi: json["yemek_adi"] as String,
        yemek_siparis_adet: int.parse(json["yemek_siparis_adet"]), yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: int.parse(json["yemek_fiyat"]), kullanici_adi: json["kullanici_adi"] as String);
  }

}