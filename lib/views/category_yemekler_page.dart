import 'package:bitirme_uygulamasi/components/myappbar.dart';
import 'package:bitirme_uygulamasi/cubit/categoryyemekler_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/homepage_cubit.dart';
import 'package:bitirme_uygulamasi/models/category.dart';
import 'package:bitirme_uygulamasi/models/yemekler.dart';
import 'package:bitirme_uygulamasi/views/detail_yemek_page.dart';
import 'package:bitirme_uygulamasi/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryYemeklerPage extends StatefulWidget {
  final Category category;

  CategoryYemeklerPage({required this.category});

  @override
  _CategoryYemeklerPageState createState() => _CategoryYemeklerPageState();
}

class _CategoryYemeklerPageState extends State<CategoryYemeklerPage> {
  List<Yemekler> yemekler = [];
  int sortSelect = 0;
  double _startValue = 0.0;
  double _endValue = 100.0;
  @override
  void initState() {
    super.initState();
    context.read<CategoryYemeklerCubit>().getAllYemeklerByCategory(widget.category.Yemekler);
  }

  Future<bool> sortAlert(List<Yemekler> yemekler) async{
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                elevation: 0.0,
                // title: Center(child: Text("Evaluation our APP")),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: width*8/10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text("Önerilen Sıralama"),
                            value: 0,
                            activeColor: mainColor,
                            groupValue: sortSelect,
                            onChanged: (value){
                              setState(() {
                                sortSelect = 0;
                                context.read<CategoryYemeklerCubit>().getAllYemeklerByCategory(widget.category.Yemekler);
                              });
                            },
                          ),
                          Divider(
                            color: mainColor,
                            thickness: 1,
                          ),
                          RadioListTile(
                            title: Text("İsme Göre Sıralama"),
                            value: 1,
                            activeColor: mainColor,
                            groupValue: sortSelect,
                            onChanged: (value){
                              setState(() {
                                sortSelect = 1;
                                context.read<CategoryYemeklerCubit>().getAllYemeklerByCategoryOrderByName(yemekler);
                              });
                            },
                          ),
                          Divider(
                            color: mainColor,
                            thickness: 1,
                          ),
                          RadioListTile(
                            title: Text("Fiyata Göre Sıralama"),
                            value: 2,
                            groupValue: sortSelect,
                            activeColor: mainColor,
                            onChanged: (value){
                              setState(() {
                                sortSelect = 2;
                                context.read<CategoryYemeklerCubit>().getAllYemeklerByCategoryOrderByPrice(yemekler);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ));
          }
        );
      },
    );
    return true;
  }

  void filterAlert(List<Yemekler> yemekler){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  elevation: 0.0,
                  // title: Center(child: Text("Evaluation our APP")),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: width*8/10,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          children: [
                            Text("Fiyat Filtrele", style: TextStyle(fontSize: 18),),
                            Row(
                              children: [
                                SizedBox(
                                  width: width/10,
                                    child: Text("${_startValue.toInt()}")
                                ),
                                SizedBox(
                                  width: width*5.5/10,
                                  child: RangeSlider(
                                    min: 0.0,
                                    max: 100.0,
                                    activeColor: mainColor,
                                    values: RangeValues(_startValue, _endValue),
                                    onChanged: (values) {
                                      setState(() {
                                        _startValue = values.start;
                                        _endValue = values.end;
                                      });
                                    },
                                    onChangeEnd: (value){
                                      context.read<CategoryYemeklerCubit>().getAllYemeklerByCategoryFilterPrice(widget.category.Yemekler, _startValue.toInt(), _endValue.toInt());
                                    },
                                  ),
                                ),
                                SizedBox(
                                    width: width/10,
                                    child: Text("${_endValue.toInt()}")
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ));
            }
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: textFieldColor,
      appBar: MyAppBar(title: widget.category.CategoryName,),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () async{
                  await sortAlert(yemekler);
                  setState(() {

                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height/100, horizontal: width*5/100),
                  shape:RoundedRectangleBorder(side: BorderSide(
                      color: mainColor,
                      width: 1.5,
                      style: BorderStyle.solid
                  ), borderRadius: BorderRadius.circular(50)),
                ),
                label: Text("Sırala", style: TextStyle(color: mainColor, fontSize: 18),),
                icon: Icon(Icons.sort, color: mainColor,),
              ),
              TextButton.icon(
                onPressed: (){
                  filterAlert(yemekler);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height/100, horizontal: width*5/100),
                  shape:RoundedRectangleBorder(side: BorderSide(
                      color: mainColor,
                      width: 1.5,
                      style: BorderStyle.solid
                  ), borderRadius: BorderRadius.circular(50)),
                ),
                label: Text("Filtrele", style: TextStyle(color: mainColor, fontSize: 18),),
                icon: Icon(Icons.filter_alt, color: mainColor,),
              ),
            ],
          ),
          BlocBuilder<CategoryYemeklerCubit, List<Yemekler>>(
            builder: (context, yemeklerList){
              yemekler = yemeklerList;
              if(yemeklerList.isNotEmpty){
                return SizedBox(
                  height: height*8/10,
                  child: ListView.builder(
                    itemCount: yemeklerList.length,
                    itemBuilder: (context, index){
                      var yemek = yemeklerList[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/food', arguments: yemek);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: width*2.2/10,
                                        height: height*1.2/10,
                                        decoration: BoxDecoration(
                                            color: textFieldColor,
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height*1.2/10,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(yemek.yemek_adi, style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.motorcycle, color: mainColor),
                                              Text("  ${yemek.yemek_fiyat}₺", style: TextStyle(
                                                fontSize: 20,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(right: width*3/100),
                                    child: IconButton(
                                      onPressed: () async{
                                        var sharedPreferences = await SharedPreferences.getInstance();
                                        var email = await sharedPreferences.getString("email");
                                        if(email != null){
                                          context.read<HomepageCubit>().yemekCartAdd(yemek, email);
                                        }
                                      },
                                      icon: Icon(Icons.add_shopping_cart, color: mainColor, size: 34),
                                      style: IconButton.styleFrom(
                                          backgroundColor: mainColor
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/sadface.png"),
                    Padding(
                      padding: EdgeInsets.only(top: height*2/100),
                      child: Text("Üzgünüz Yemek Bulunamadı...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    )
                  ],
                );
              }
            },
          ),
        ],
      )
    );
  }
}
