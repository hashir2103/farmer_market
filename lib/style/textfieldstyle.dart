import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/material.dart';

abstract class TextFieldStyle {
  static TextStyle get text => TextStyles.body;

  static TextStyle get placeHolder => TextStyles.suggestion;

  static Color get cursorColor => AppColor.darkblue;

  static TextAlign get textAlign => TextAlign.center;

  static Widget iconPrefix(IconData icon) => BaseStyle.iconPrefix(icon);

  static BoxDecoration get cupertinoDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColor.straw, width: BaseStyle.borderRaduis),
      borderRadius: BorderRadius.circular(BaseStyle.borderwidth),
    );
  }

  static BoxDecoration get cupertinoErrorDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColor.red, width: BaseStyle.borderRaduis),
      borderRadius: BorderRadius.circular(BaseStyle.borderwidth),
    );
  }

  static InputDecoration materialDecoration(
      {String hintText, IconData icon, String errorText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      hintText: hintText,
      errorText: errorText,
      errorStyle: TextStyles.errorText,
      hintStyle: TextFieldStyle.placeHolder,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColor.straw, width: BaseStyle.borderwidth),
        borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColor.straw, width: BaseStyle.borderwidth),
        borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColor.straw, width: BaseStyle.borderwidth),
        borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColor.red, width: BaseStyle.borderwidth),
        borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
      ),
      prefixIcon: iconPrefix(icon),
    );
  }
}
