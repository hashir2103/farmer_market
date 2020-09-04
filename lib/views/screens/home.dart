import 'package:farmer_market/views/widgets/AppButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(child: pageBody(context));
    }
    return Scaffold(body: pageBody(context));
  }

  pageBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          buttonText: "Vendor Page",                                            
          buttonType: ButtonType.Straw,
          onPressed: () => Navigator.pushNamed(context, '/vendor'),
        )
      ],
    );
  }
}
