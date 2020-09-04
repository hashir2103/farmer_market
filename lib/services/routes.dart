import 'package:farmer_market/views/screens/Edit_product.dart';
import 'package:farmer_market/views/screens/home.dart';
import 'package:farmer_market/views/screens/login.dart';
import 'package:farmer_market/views/screens/signUp.dart';
import 'package:farmer_market/views/screens/vendor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static MaterialPageRoute materialPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignUp());

      case '/login':
        return MaterialPageRoute(builder: (context) => Login());

      case '/vendor':
        return MaterialPageRoute(builder: (context) => Vendor());

      case '/editproduct':
        return MaterialPageRoute(builder: (context) => EditProduct());

      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editproduct/')) {
          print(routeArray[2]);
          return MaterialPageRoute(
              builder: (context) => EditProduct(
                    productId: routeArray[2],
                  ));
        }
        return MaterialPageRoute(builder: (context) => Home());
    }
  }

  static CupertinoPageRoute cupertinoPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (context) => Home());

      case '/signup':
        return CupertinoPageRoute(builder: (context) => SignUp());

      case '/login':
        return CupertinoPageRoute(builder: (context) => Login());

      case '/vendor':
        return CupertinoPageRoute(builder: (context) => Vendor());

      case '/editproduct':
        return CupertinoPageRoute(builder: (context) => EditProduct());

      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editproduct/')) {
          return CupertinoPageRoute(
              builder: (context) => EditProduct(
                    productId: routeArray[2],
                  ));
        }
        return CupertinoPageRoute(builder: (context) => Home());
    }
  }
}
