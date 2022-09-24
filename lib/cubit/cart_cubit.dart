import 'package:bitirme_uygulamasi/models/sepet_yemekler.dart';
import 'package:bitirme_uygulamasi/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<List<SepetYemekler>>{
  CartCubit():super(<SepetYemekler>[]);

  var yRepo = YemeklerDaoRepository();

  Future<String> getEmail() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString("email");
    if(email != null){
      return email;
    }
    return "";
  }

  Future<void> cartGetAllByEmail(String email) async{
    var seen = Set<String>();
    var list = await yRepo.getAllCart(email);
    var list_yemekler = await yRepo.getAllYemekler();
    if(list.isNotEmpty){
      var distincitList = await list.where((element) => seen.add(element.yemek_adi)).toList();
      for (var d in distincitList) {
        if (list.where((element) => element.yemek_adi == d.yemek_adi).toList().length != 1) {
          var count = 0;
          list.where((element) => element.yemek_adi == d.yemek_adi).forEach((element) {count += element.yemek_siparis_adet;});
          d.yemek_siparis_adet = count;
        }
        d.yemek_id =await list_yemekler.where((yemekler) => yemekler.yemek_adi == d.yemek_adi).first.yemek_id.toString();
      }
      emit(distincitList);
    }
    else{
      emit(list);
    }
  }

  Future<void> cartDeleteAllByEmail() async{
    var email;
    await getEmail().then((value) {
      email = value;
    });
    if(email != ""){
      var list = await yRepo.getAllCart(email);
      if(list.isNotEmpty){
        await Future.forEach(list, (element) => yRepo.deleteCart(email, element.sepet_yemek_id));
        cartGetAllByEmail(email);
      }else{
        print("Sepette yemek yok");
      }
    }
  }

  Future<void> cartDeleteByEmailYemekname(String yemek_name) async{
    var email;
    await getEmail().then((value) {
      email = value;
    });
    if(email != ""){
      var list = await yRepo.getAllCart(email);
      list = await list.where((element) => element.yemek_adi == yemek_name).toList();
      if(list.isNotEmpty){
        await Future.forEach(list, (element) => yRepo.deleteCart(email, element.sepet_yemek_id));
        cartGetAllByEmail(email);
      }else{
        print("Sepette yemek yok");
      }
    }
  }
}