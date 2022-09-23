import 'package:bitirme_uygulamasi/cubit/address_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/cart_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/category_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/categoryyemekler_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/detailyemek_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/homepage_cubit.dart';
import 'package:bitirme_uygulamasi/cubit/order_cubit.dart';
import 'package:bitirme_uygulamasi/my_router.dart';
import 'package:bitirme_uygulamasi/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomepageCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => DetailYemekCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => CategoryYemeklerCubit()),
        BlocProvider(create: (context) => AddressCubit()),
        BlocProvider(create: (context) => OrderCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MyRouter.generateRoute,
        initialRoute: homeRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Homepage(),
      ),
    );
  }
}
