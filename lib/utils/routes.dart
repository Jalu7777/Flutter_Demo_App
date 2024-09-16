import 'package:flutter/material.dart';
import 'package:flutter_app_demo/screen/product.dart';

import '../screen/home.dart';
import '../screen/spalsh.dart';

class RoutesName {
  static String initialRoute = '/';
  static String homeRoute = '/home';
  static String productRoute = '/product';
}

class Routes {
  static Map<String, WidgetBuilder> m1 = {
    RoutesName.initialRoute: (context) => const Splah(),
    RoutesName.homeRoute: (context) => const Home(),
    RoutesName.productRoute: (context) => const Product(),
  };
}
