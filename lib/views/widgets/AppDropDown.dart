import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/buttonstyle.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AppDropDownButton extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final IconData materialIcon;
  final IconData cupertinoIcon;
  final String value;
  final Function(String) onChanged;
  AppDropDownButton(
      {@required this.items,
      @required this.hintText,
      this.materialIcon,
      this.cupertinoIcon,
      this.value,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: BaseStyle.listPadding,
        child: Container(
          height: ButtonStyle.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border:
                Border.all(color: AppColor.straw, width: BaseStyle.borderwidth),
            borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
          ),
          child: Row(
            children: [
              Container(
                width: 35,
                child: BaseStyle.iconPrefix(materialIcon),
              ),
              Expanded(
                  child: GestureDetector(
                child: (value == null)
                    ? Text(
                        hintText,
                        style: TextStyles.suggestion,
                      )
                    : Text(
                        value,
                        style: TextStyles.body,
                      ),
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return _selectIOS(context, items, value);
                      });
                },
              )),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: BaseStyle.listPadding,
        child: Container(
          height: ButtonStyle.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border:
                Border.all(color: AppColor.straw, width: BaseStyle.borderwidth),
            borderRadius: BorderRadius.circular(BaseStyle.borderRaduis),
          ),
          child: Row(
            children: [
              Container(
                child: BaseStyle.iconPrefix(materialIcon),
              ),
              Expanded(
                child: Center(
                  child: DropdownButton<String>(
                    items: buildMaterialItems(items),
                    hint: Text(
                      hintText,
                      style: TextStyles.suggestion,
                    ),
                    style: TextStyles.body,
                    underline: Container(),
                    value: value,
                    onChanged: (value) => onChanged(value),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<DropdownMenuItem<String>> buildMaterialItems(List<String> items) {
    if (items != null) {
      return items
          .map((item) => DropdownMenuItem<String>(
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                ),
                value: item,
              ))
          .toList();
    }
    return null;
  }

  List<Widget> buildCupertinoItems(List<String> items) {
    return items
        .map(
          (item) => Text(
            item,
            textAlign: TextAlign.center,
            style: TextStyles.picker,
          ),
        )
        .toList();
  }

  _selectIOS(BuildContext context, List<String> items, value) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.white,
        height: 200.0,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: items.indexWhere((item) => item == value)),
          itemExtent: 45.0,
          children: buildCupertinoItems(items),
          diameterRatio: 1.0,
          onSelectedItemChanged: (int index) {
            onChanged(items[index]);
          },
        ),
      ),
    );
  }
}
