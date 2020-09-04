import 'package:farmer_market/blocs/auth_bloc.dart';
import 'package:farmer_market/blocs/product_bloc.dart';
import 'package:farmer_market/models/product.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/views/widgets/AppCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return pageBody(productBloc, context, authBloc.userId);
  }

  Widget pageBody(
      ProductBloc productBloc, BuildContext context, String vendorId) {
    return StreamBuilder<List<Product>>(
        stream: productBloc.productByVendorId(vendorId),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: (Platform.isIOS)
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator());

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var product = snapshot.data[index];
                      return GestureDetector(
                        child: AppCard(
                          availableUnit: product.availableUnits,
                          price: product.unitPrice,
                          productName: product.productName,
                          unitType: product.unitType,
                          imagrUrl: product.imageUrl,
                        ),
                        onTap: () {
                          // print(product.productId.toUpperCase());
                          Navigator.of(context)
                              .pushNamed('/editproduct/${product.productId}');
                        },
                      );
                    }),
              ),
              GestureDetector(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    color: AppColor.straw,
                    child: (Platform.isIOS)
                        ? Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                            size: 35,
                          )
                        : Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35,
                          )),
                onTap: ()=> Navigator.of(context).pushNamed('/editproduct'),          
              )
            ],
          );
        });
  }
}
