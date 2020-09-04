import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/views/widgets/orders.dart';
import 'package:farmer_market/views/widgets/products.dart';
import 'package:farmer_market/views/widgets/profile.dart';
import 'package:flutter/cupertino.dart';

abstract class VendorScaffold {
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
              icon: Icon(CupertinoIcons.shopping_cart), title: Text('Orders')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text('Profile')),
        ]);
  }

  static _pageSelection(int index) {
    if (index == 0) {
      return Products();
    }
    if (index == 1) {
      return Orders();
    }

    return Profile();
  }
}
