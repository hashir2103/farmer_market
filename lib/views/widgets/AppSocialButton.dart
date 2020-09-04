import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/buttonstyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSocialButton extends StatelessWidget {
  final SocialType socialType;

  AppSocialButton({@required this.socialType});

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color iconColor;
    IconData icon;

    switch (socialType) {
      case SocialType.Facebook:
        buttonColor = AppColor.facebook;
        iconColor = Colors.white;
        icon = FontAwesomeIcons.facebookF;
        break;
      case SocialType.Google:
        buttonColor = AppColor.google;
        iconColor = Colors.white;
        icon = FontAwesomeIcons.google;
        break;
      default:
        buttonColor = AppColor.facebook;
        iconColor = Colors.white;
        icon = FontAwesomeIcons.facebookF;
        break;
    }
    return Container(
      height: ButtonStyle.buttonHeight,
      width: ButtonStyle.buttonHeight,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
          boxShadow: BaseStyle.boxShadow),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}

enum SocialType {
  Google,
  Facebook,
}
