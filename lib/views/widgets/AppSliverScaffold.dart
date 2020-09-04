import 'package:farmer_market/views/widgets/AppNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class AppSliverScaffold {
  static CupertinoPageScaffold cupertinoSliverScaffold(
      {String navTitle, Widget pageBody, BuildContext context}) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppNavbar.cupertinoNavBar(title: navTitle,context:context),
          ];
        },
        body: pageBody,
      ),
    );
  }

  static Scaffold materialSliverScaffold(
      {String navTitle, Widget pageBody, BuildContext context}) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppNavbar.materialNavBar(title: navTitle,pinned: false)
          ];
        },
        body: pageBody
      )
    );
  }
}
