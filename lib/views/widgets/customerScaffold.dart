import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/views/widgets/product_customer.dart';
import 'package:farmer_market/views/widgets/profile_customer.dart';
import 'package:farmer_market/views/widgets/shopping_bag.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class CustomerScaffold {
  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold(
        tabBar: _cupertinoTabBar,
        tabBuilder: (context, index) {
          return _pageSelection(index);
        });
  }

  static get _cupertinoTabBar {
    return CupertinoTabBar(
        backgroundColor: AppColor.darkblue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.create), title: Text('Products')),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.shoppingBag), title: Text('Orders')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text('Profile')),
        ]);
  }

  static _pageSelection(int index) {
    if (index == 0) {
      return ProductsCustomer();
    }
    if (index == 1) {
      return ShoppingBag();
    }

    return ProfileCustomer();
  }
}
