import 'dart:async';
import 'dart:io';

import 'package:farmer_market/blocs/auth_bloc.dart';
import 'package:farmer_market/style/tabBarStyle.dart';
import 'package:farmer_market/views/widgets/AppNavBar.dart';
import 'package:farmer_market/views/widgets/orders.dart';
import 'package:farmer_market/views/widgets/products.dart';
import 'package:farmer_market/views/widgets/profile.dart';
import 'package:farmer_market/views/widgets/VendorScaffoldCupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Vendor extends StatefulWidget {
  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  StreamSubscription _userSubscription;
  @override
  void initState() {
    //for logout
    Future.delayed(Duration.zero, () {
      var authBloc = Provider.of<AuthBloc>(context, listen: false);
      _userSubscription = authBloc.user.listen((user) {
        if (user == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              AppNavbar.cupertinoNavBar(title: "Vendor Name",context: context),
            ];
          },
          body: VendorScaffold.cupertinoTabScaffold,
        ),
      );
    } else {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    AppNavbar.materialNavBar(
                        title: 'Vendor Name', tabBar: vendorTabBarMaterial)
                  ];
                },
                body: TabBarView(children: [Products(), Orders(), Profile()])),
          ));
    }
  }

  static TabBar get vendorTabBarMaterial {
    return TabBar(
        unselectedLabelColor: TabBarStyle.unselectedLabelColor,
        labelColor: TabBarStyle.labelColor,
        indicatorColor: TabBarStyle.indicatorColor,
        tabs: [
          Tab(
            icon: Icon(Icons.list),
          ),
          Tab(
            icon: Icon(Icons.shopping_cart),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
        ]);
  }
}
