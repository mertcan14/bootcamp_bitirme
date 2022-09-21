import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/yemekler_dao_repository.dart';

class CategoryYemeklerCubit extends Cubit<List<Yemekler>>{
  CategoryYemeklerCubit():super(<Yemekler>[]);

  var yRepo = YemeklerDaoRepository();

  List<Yemekler> sortYemekler(List<Yemekler> yemekler, String title) {
    if(title == "Price"){
      yemekler.sort((a,b) => a.yemek_fiyat.compareTo(b.yemek_fiyat));
    }
    else if(title == "Name"){
      yemekler.sort((a,b) => a.yemek_adi.compareTo(b.yemek_adi));
    }

    return yemekler;
  }

  Future<void> getAllYemeklerByCategory(List<dynamic> listYemekId) async{
    var list = await yRepo.getAllYemekler();
    List<Yemekler> yemekler = [];
    listYemekId.forEach((element) {
      yemekler.add(list.where((yemek) => yemek.yemek_id == element).first);
    });
    yemekler.shuffle();
    emit(yemekler);
  }

  Future<void> getAllYemeklerByCategoryOrderByName(List<Yemekler> yemekler) async{
    await sortYemekler(yemekler, "Name");
    emit(yemekler);
  }

  Future<void> getAllYemeklerByCategoryOrderByPrice(List<Yemekler> yemekler) async{
    await sortYemekler(yemekler, "Price");
    emit(yemekler);
  }

  Future<void> getAllYemeklerByCategoryFilterPrice(List<dynamic> listYemekId, int minPrice, int maxPrice) async{
    var list = await yRepo.getAllYemekler();
    List<Yemekler> yemekler = [];
    listYemekId.forEach((element) {
      yemekler.add(list.where((yemek) => yemek.yemek_id == element).first);
    });
    emit(yemekler.where((element) => element.yemek_fiyat>=minPrice && element.yemek_fiyat<=maxPrice).toList());
  }
}