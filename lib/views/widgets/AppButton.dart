import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/buttonstyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final ButtonType buttonType;
  final void Function() onPressed;
  AppButton({@required this.buttonText, this.buttonType, this.onPressed});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle;
    Color buttonColor;

    switch (widget.buttonType) {
      case ButtonType.Straw:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColor.straw;
        break;
      case ButtonType.LightBlue:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColor.lightblue;
        break;
      case ButtonType.DarkBlue:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColor.darkblue;
        break;
      case ButtonType.Disable:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColor.lightgray;
        break;
      case ButtonType.DarkGray:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColor.darkgray;
        break;
      default:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColor.lightblue;
        break;
    }
    return Padding(
      padding: EdgeInsets.only(
        top: (pressed == true)
            ? BaseStyle.verticalPadding + 5
            : BaseStyle.verticalPadding,
        bottom: (pressed == true)
            ? BaseStyle.verticalPadding - 5
            : BaseStyle.verticalPadding,
        right: BaseStyle.horizontalPadding,
        left: BaseStyle.horizontalPadding,
      ),
      child: GestureDetector(
        onTapDown: (details) {
          if (widget.buttonType != ButtonType.Disable) {
            setState(() {
              pressed = !pressed;
            });
          }
        },
        onTapUp: (details) {
          setState(() {
            if (widget.buttonType != ButtonType.Disable) {
              pressed = !pressed;
            }
          });
        },
        onTap: () {
          if (widget.buttonType != ButtonType.Disable) {
            widget.onPressed();
          }
        },
        child: Container(
          height: ButtonStyle.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
              boxShadow: BaseStyle.boxShadow),
          child: Center(
              child: Text(
            widget.buttonText,
            style: fontStyle,
          )),
        ),
      ),
    );
  }
}

enum ButtonType { LightBlue, Straw, DarkGray, DarkBlue, Disable }
