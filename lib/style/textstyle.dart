import 'package:farmer_market/style/colorsStyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  
  static TextStyle get title {
    return GoogleFonts.economica(
        textStyle: TextStyle(
          color: AppColor.darkblue,
          fontSize: 40.0,
          fontWeight: FontWeight.bold));
  }
  static TextStyle get subTitle {
    return GoogleFonts.economica(
        textStyle: TextStyle(
          color: AppColor.straw,
          fontSize: 30.0,
          fontWeight: FontWeight.bold));
  }
  static TextStyle get navTitle {
    return GoogleFonts.poppins(
        textStyle:
            TextStyle(color: AppColor.darkblue, fontWeight: FontWeight.bold));
  }

  static TextStyle get navTitleMaterial {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
  
  static TextStyle get body {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.darkgray, fontSize: 18.0));
  }
  
  static TextStyle get bodyLightBlue {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.lightblue, fontSize: 18.0));
  }
  static TextStyle get bodyRed {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.red, fontSize: 18.0));
  }
  static TextStyle get picker {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.darkgray, fontSize: 35.0));
  }

  static TextStyle get suggestion {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.lightgray, fontSize: 16.0));
  }
  static TextStyle get errorText {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.red, fontSize: 12.0));
  }

  static TextStyle get buttonTextLight {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.bold));
  }
  static TextStyle get buttonTextDark {
    return GoogleFonts.roboto(textStyle: TextStyle(
      color: AppColor.darkgray,
      fontSize: 19.0,
      fontWeight: FontWeight.bold
    ));
  }
  static TextStyle get link {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColor.straw, fontSize: 18.0,fontWeight: FontWeight.bold));
  }
}
