import 'dart:io';

import 'package:farmer_market/blocs/customer_bloc.dart';
import 'package:farmer_market/models/product.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductsCustomer extends StatelessWidget {
  final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'en_PK', name: 'PKR', decimalDigits: 2);
  @override
  Widget build(BuildContext context) {
    var customerBloc = Provider.of<CustomerBloc>(context);
    return StreamBuilder<List<Product>>(
        stream: customerBloc.fetchAvailableProducts,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: (Platform.isIOS)
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var product = snapshot.data[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: (product.imageUrl != "")
                                    ? NetworkImage(product.imageUrl)
                                    : AssetImage(
                                        "assets/images/vegetables.png"),
                                radius: 30,
                              ),
                              title: Text(
                                product.productName,
                                style: TextStyles.subTitle,
                              ),
                              subtitle: Text('The Vendor Name'),
                              trailing: Text(
                                "${formatCurrency.format(product.unitPrice)}/${product.unitType}",
                                style: TextStyles.bodyLightBlue,
                              ),
                            ),
                            Divider(
                              color: AppColor.lightgray,
                            )
                          ],
                        );
                      }),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: AppColor.straw,
                  child: (Platform.isIOS)
                      ? Icon(
                          IconData(0xF38B,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage),
                          color: Colors.white,
                          size: 35)
                      : Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 35,
                        ),
                )
              ],
            ),
          );
        });
  }
}
