import 'package:flutter/material.dart';
import 'package:jd_project/main.dart';
import 'package:jd_project/pages/Address/AddressAdd.dart';
import 'package:jd_project/pages/Address/AddressEdit.dart';
import 'package:jd_project/pages/Address/AddressList.dart';
import 'package:jd_project/pages/Login/Login.dart';
import 'package:jd_project/pages/ProductContent/ProductContent.dart';
import 'package:jd_project/pages/Register/register.dart';
import 'package:jd_project/pages/checkout/MyCheckOut.dart';
import 'package:jd_project/pages/checkout/checkout.dart';
import 'package:jd_project/pages/checkout/checkoutDetail.dart';
import 'package:jd_project/pages/search/ProductList.dart';
import 'package:jd_project/pages/search/Search.dart';
import 'package:jd_project/pages/shopping_car/shopping_car.dart';
import 'package:jd_project/test.dart';
//配置路由
final routes = {
  '/': (context) => MainHome(),
  '/test': (context) => test(),
  '/product':(context,{arguments})=>ProductList(arguments:arguments),
  '/search':(context,{arguments})=>Search(arguments:arguments),
  '/cart':(context) => Shopping_Car(),
  '/login':(context) => LoginPage(),
  '/register':(context) => RegisterPage(),
  '/checkout':(context) => CheckOut(),
  '/addressedit':(context) => AddressEdit(),
  '/addressadd':(context) => AddressAdd(),
  '/addresslist':(context) => AddressList(),
  '/checkoutdetail':(context) => CheckOutDetail(),
  '/mycheckout':(context)=>  MyCheckOut(),
  '/ProductContent':(context,{arguments})=>ProductContentPage(arguments:arguments),
};
//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
