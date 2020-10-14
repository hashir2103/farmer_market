import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppListTile extends StatelessWidget {
  final String month;
  final String date;
  final String title;
  final String location;
  final bool acceptingOrder;
  final String marketId;

  const AppListTile(
      {Key key,
      @required this.month,
      @required this.date,
      @required this.title,
      @required this.location,
      @required this.marketId,
      this.acceptingOrder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.lightblue,
            child: Column(
              children: [
                Text(
                  month,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(date, style: TextStyles.buttonTextLight)
              ],
            ),
          ),
          title: Text(
            title,
            style: TextStyles.subTitle,
          ),
          subtitle: Text(location),
          trailing: (acceptingOrder)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: BaseStyle.horizontalPadding),
                  child: Icon(FontAwesomeIcons.shoppingBasket),
                )
              : Text(''),
          onTap: (acceptingOrder) ? ()=> Navigator.pushNamed(context, '/customer/$marketId') : null,    
        ),
        Divider(
          indent: BaseStyle.horizontalPadding,
          endIndent: BaseStyle.horizontalPadding,
          thickness: 0.5,
          color: AppColor.lightblue,
        )
      ],
    );
  }
}
