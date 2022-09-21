import 'package:bitirme_uygulamasi/views/auth_page.dart';
import 'package:bitirme_uygulamasi/views/cart_page.dart';
import 'package:bitirme_uygulamasi/views/category_yemekler_page.dart';
import 'package:bitirme_uygulamasi/views/homepage.dart';
import 'package:bitirme_uygulamasi/views/login.dart';
import 'package:bitirme_uygulamasi/views/onboarding/onboarding_content_page.dart';
import 'package:bitirme_uygulamasi/views/onboarding/onboarding_page.dart';
import 'package:bitirme_uygulamasi/views/onboarding/onboarding_welcome_page.dart';
import 'package:bitirme_uygulamasi/views/register_page.dart';
import 'package:bitirme_uygulamasi/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRouter{
  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    final args = routeSettings.arguments;
    switch (routeSettings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Homepage());
      case cartRoute:
        return MaterialPageRoute(builder: (_)=>CartPage());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_)=>OnboardingPage());
      case onboardingContentRoute:
        return MaterialPageRoute(builder: (_)=>OnboardingContentPage());
      case onboardingWelcomeRoute:
        return MaterialPageRoute(builder: (_)=>OnboardingWelcomPage());
      case authRoute:
        return MaterialPageRoute(builder: (_)=>AuthPage());
      case loginRoute:
        return MaterialPageRoute(builder: (_)=>Login());
      case registerRoute:
        return MaterialPageRoute(builder: (_)=>RegisterPage());
      case categoryRoute:
        if(args is Category){
          return MaterialPageRoute(builder: (_)=>CategoryYemeklerPage(category: args));
        }
        return MaterialPageRoute(builder: (_)=>Homepage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Yol Bulunamadı'),
            ),
          ),
        );
    }
  }
}

const String homeRoute = '/';
const String cartRoute = '/cart';
const String categoryRoute = '/category';

const String onboardingRoute = '/onboarding';
const String onboardingContentRoute = '/onboarding/content';
const String onboardingWelcomeRoute = '/onboarding/welcome';

const String authRoute = '/auth';
const String loginRoute = '/login';
const String registerRoute = '/register';
