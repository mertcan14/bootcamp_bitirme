import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:bitirme_uygulamasi/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomepageCubit extends Cubit<List<Yemekler>>{
  HomepageCubit():super(<Yemekler>[]);

  var yRepo = YemeklerDaoRepository();


  Future<void> yemeklerGetAll() async{
    var list = await yRepo.getAllYemekler();
    emit(list);
  }

  Future<void> yemeklerSearch(String query) async{
    var list = await yRepo.getAllYemekler();
    List<Yemekler> matchQuery=[];
    for(var data in list){
      if(data.yemek_adi.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(data);
      }
    }
    emit(matchQuery);
  }

  Future<void> yemekCartAdd(Yemekler yemek, String email)async{
    await yRepo.addYemekCart(yemek, email);
  }

}