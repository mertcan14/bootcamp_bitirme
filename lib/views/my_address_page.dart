import 'package:bitirme_uygulamasi/components/myappbar.dart';
import 'package:bitirme_uygulamasi/cubit/address_cubit.dart';
import 'package:bitirme_uygulamasi/models/address.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyAddressPage extends StatefulWidget {
  String Token;

  MyAddressPage({required this.Token});

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  var addressLength;
  @override
  void initState() {
    super.initState();
    getAddressByToken();
  }

  Future<void> getAddressByToken() async{
    context.read<AddressCubit>().getAllAddress(widget.Token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Adreslerim",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<AddressCubit, List<AddressUser>>(
          builder: (context, addressList){
            if(addressList.isNotEmpty){
              addressLength = addressList.length;
              return ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (context, index){
                  var address = addressList[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context){
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          icon: Icons.delete,
                          label: 'Sil',
                        ),
                      ],
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(address.AddressTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${address.City}/${address.District}"),
                              ],
                            ),
                            Text(address.Address),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return const Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/address/add", arguments: [widget.Token, addressLength.toString()]).then((value) => context.read<AddressCubit>().getAllAddress(widget.Token));
        },
        child: Icon(Icons.add),
        backgroundColor: mainColor,
      ),
    );
  }
}
