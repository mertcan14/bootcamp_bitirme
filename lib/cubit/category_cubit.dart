import 'package:bitirme_uygulamasi/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<List<Category>>{
  CategoryCubit():super(<Category>[]);

  var refKisiler = FirebaseFirestore.instance.collection("Category");

  Future<void> getAllCategory() async{
    List<Category> categoryList = [];
    await refKisiler.orderBy("CategoryName").get().then((snapshot) {
      if(snapshot.docs.isNotEmpty){
        for(var data in snapshot.docs){
          categoryList.add(Category.fromJson(data.data()));
        }
      }
    });
    emit(categoryList);
  }
}