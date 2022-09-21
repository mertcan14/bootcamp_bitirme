import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:bitirme_uygulamasi/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailYemekCubit extends Cubit<void>{
  DetailYemekCubit():super(0);

  var yRepo = YemeklerDaoRepository();

  Future<void> yemekCartAddWithTotal(Yemekler yemek, String email, int total)async{
    await yRepo.addYemekCartWithTotal(yemek, email, total);
  }
}