import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class AppAlert {
  static Future<void> showErrorDialog(
      bool isIOS, BuildContext context, String errorMsg) async {
    return (isIOS)
        ? showDialog(
            context: context,
            barrierDismissible:
                false, //that means user can't click outside have to click ok to pop
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  'Error',
                  style: TextStyles.subTitle,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        errorMsg,
                        style: TextStyles.body,
                      )
                    ],
                  ),
                ),
                actions: [
                  CupertinoButton(
                    child: Text(
                      'Close',
                      style: TextStyles.body,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            })
        : showDialog(
            context: context,
            barrierDismissible:
                false, //that means user cant click outside have to click ok to pop
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Error',
                  style: TextStyles.subTitle,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        errorMsg,
                        style: TextStyles.body,
                      )
                    ],
                  ),
                ),
                actions: [                                                     
                  FlatButton(
                    child: Text(
                      'Close',
                      style: TextStyles.body,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            });
  }
}
