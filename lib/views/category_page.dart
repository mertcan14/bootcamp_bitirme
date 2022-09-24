import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/category_cubit.dart';
import '../models/category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return BlocBuilder<CategoryCubit, List<Category>>(
      builder: (context, categoryList){
        if(categoryList.isNotEmpty){
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1/1,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index){
              var category = categoryList[index];
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, "/category", arguments: category);
                },
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/100),
                        child: Image.asset(category.ImagePath, width: width/4, height: height*8/100, fit:BoxFit.contain)
                    ),
                    Text(category.CategoryName, style: TextStyle(fontFamily: "Lora", fontWeight: FontWeight.w600, fontSize: 16 ),)
                  ],
                ),
              );
            },
          );
        }else{
          return const Center();
        }
      },
    );
  }
}
