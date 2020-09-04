import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppCard extends StatelessWidget {
  final String productName;
  final String note;
  final String unitType;
  final int availableUnit;
  final double price;
  final String imagrUrl;
  final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'en_PK', name: 'PKR', decimalDigits: 2);

  AppCard(
      {@required this.productName,
      @required this.unitType,
      @required this.availableUnit,
      @required this.price,
      this.note, this.imagrUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseStyle.listPadding,
      padding: BaseStyle.listPadding,
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColor.darkblue, width: BaseStyle.borderwidth),
          borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
          boxShadow: BaseStyle.boxShadow,
          color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start ,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
                child: (imagrUrl != null && imagrUrl != "")
                ? ClipRRect(child: Image.network(imagrUrl,height: 100,), borderRadius: BorderRadius.circular(8),)
                : Image.asset(
                  "assets/images/vegetables.png",
                  height: 100,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyles.subTitle,
                  ),
                  Text(
                    "${formatCurrency.format(price)}/$unitType",
                    style: TextStyles.body,
                  ),
                  (availableUnit > 0)
                      ? Text(
                          "In Stock",
                          style: TextStyles.bodyLightBlue,
                        )
                      : Text(
                          "Current Unavailable",
                          style: TextStyles.bodyRed,
                        ),
                ],
              ),
            ],
          ),
          Text(
            "This is Note Space",
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }
}
