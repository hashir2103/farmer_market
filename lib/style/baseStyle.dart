import 'package:farmer_market/style/colorsStyle.dart';
import 'package:flutter/material.dart';

abstract class BaseStyle {
  static double get borderRaduis => 25.0;

  static double get borderwidth => 2.0;
  static double get verticalPadding => 9.0;
  static double get horizontalPadding => 30.0;

  
  static EdgeInsets get listPadding {
    return EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding);
  }

  static List<BoxShadow> get boxShadow {
    return [
      BoxShadow(
        color: AppColor.darkgray.withOpacity(0.5),
        offset: Offset(1, 2),
        blurRadius: 2,
      )
    ];
  }

  static Widget iconPrefix(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Icon(
        icon,
        size: 35.0,
        color: AppColor.lightblue,
      ),
    );
  }
}
