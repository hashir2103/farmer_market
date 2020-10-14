import 'package:date_format/date_format.dart';
import 'package:farmer_market/blocs/customer_bloc.dart';
import 'package:farmer_market/models/market.dart';
import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:farmer_market/views/widgets/AppListTile.dart';
import 'package:farmer_market/views/widgets/AppSliverScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var customerBloc = Provider.of<CustomerBloc>(context);
    if (Platform.isIOS) {
      return AppSliverScaffold.cupertinoSliverScaffold(
          navTitle: "Upcoming Market",
          pageBody: Scaffold(
            body: pageBody(context, customerBloc),
          ));
    }
    return AppSliverScaffold.materialSliverScaffold(
        pageBody: pageBody(context, customerBloc), navTitle: "Upcoming Market");
  }

  pageBody(context, CustomerBloc customerBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Stack(
            children: [
              Positioned(child: Image.asset("assets/images/market.jpg")),
              Positioned(
                  bottom: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/vendor"),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.lightblue,
                          borderRadius:
                              BorderRadius.circular(BaseStyle.borderRaduis)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Vendor Page",
                          style: TextStyles.buttonTextLight,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          flex: 2,
        ),
        Flexible(
          flex: 3,
          child: StreamBuilder<List<Market>>(
              stream: customerBloc.fetchUpcomingMarket,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: (Platform.isIOS)
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(),
                  );
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var market = snapshot.data[index];
                      var dateEnd = DateTime.parse(market.dateEnd);
                      return AppListTile(
                          marketId: market.marketId,
                          month: formatDate(dateEnd, ['M']),
                          date: formatDate(dateEnd, ['d']),
                          title: market.title,
                          acceptingOrder: market.acceptingOrders,
                          location:
                              '${market.location.name}, ${market.location.address}, ${market.location.city}, ${market.location.state}');
                    });
              }),
        ),
      ],
    );
  }
}
