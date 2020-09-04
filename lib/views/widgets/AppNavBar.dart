import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppNavbar {

  static CupertinoSliverNavigationBar cupertinoNavBar ({String title,@required BuildContext context}) {
    return CupertinoSliverNavigationBar(  
      largeTitle: Text(title, style: TextStyles.navTitle),
      backgroundColor: Colors.transparent,
      border: null,
      leading: GestureDetector(child: Icon(CupertinoIcons.back, color: AppColor.straw),onTap: () => Navigator.of(context).pop(),)
    );
  }

  static SliverAppBar materialNavBar({@required String title, bool pinned,TabBar tabBar}) {
      return SliverAppBar(
      title: Text(title, style: TextStyles.navTitleMaterial),
      backgroundColor: AppColor.darkblue,
      bottom: tabBar,
      floating: true,
      pinned: (pinned ==null) ? true : pinned,
      snap: true,
    );

  }
}