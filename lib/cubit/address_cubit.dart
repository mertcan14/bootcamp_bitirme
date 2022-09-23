import 'package:bitirme_uygulamasi/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<List<AddressUser>>{
  AddressCubit():super(<AddressUser>[]);

  var refAddress = FirebaseFirestore.instance.collection("Address");

  Future<void> getAllAddress(String token) async{
    List<AddressUser> addressList = [];
    await refAddress.doc(token).get().then((snapshot) {
      if(snapshot != null){
        for(var address in snapshot.get("Addresses") as List){
          addressList.add(AddressUser.fromJson(address));
        }
      }
    });
    emit(addressList);
  }
}