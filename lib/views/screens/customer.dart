import 'dart:async';
import 'dart:io';

import 'package:farmer_market/blocs/auth_bloc.dart';
import 'package:farmer_market/style/tabBarStyle.dart';
import 'package:farmer_market/views/widgets/AppNavBar.dart';
import 'package:farmer_market/views/widgets/customerScaffold.dart';
import 'package:farmer_market/views/widgets/product_customer.dart';
import 'package:farmer_market/views/widgets/profile_customer.dart';
import 'package:farmer_market/views/widgets/shopping_bag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Customer extends StatefulWidget {
  final String marketId;

  const Customer({Key key,@required this.marketId}) : super(key: key);
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
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
              AppNavbar.cupertinoNavBar(
                  title: "Customer Name", context: context),
            ];
          },
          body: CustomerScaffold.cupertinoTabScaffold,
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
                        title: 'Customer Name', tabBar: customerTabBarMaterial)
                  ];
                },
                body: TabBarView(children: [ProductsCustomer(), ShoppingBag(), ProfileCustomer()])),
          ));
    }
  }

  static TabBar get customerTabBarMaterial {
    return TabBar(
        unselectedLabelColor: TabBarStyle.unselectedLabelColor,
        labelColor: TabBarStyle.labelColor,
        indicatorColor: TabBarStyle.indicatorColor,
        tabs: [
          Tab(
            icon: Icon(Icons.list),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.shoppingBag),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
        ]);
  }
}
