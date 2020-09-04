import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/textfieldstyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final bool isIOS;
  final String hintText;
  final IconData cupertinoIcon;
  final IconData materialIcon;
  final TextInputType textInputType;
  final bool obsecureText;
  final void Function(String) onChanged;
  final String errorText;
  final String initialText;

  AppTextField(
      {@required this.isIOS,
      @required this.hintText,
      @required this.cupertinoIcon,
      @required this.materialIcon,
      this.textInputType = TextInputType.text,
      this.obsecureText = false,
      this.onChanged,
      this.errorText,
      this.initialText});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode _focusNode;
  bool displayCupertionErrorBorder;
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    if (widget.initialText != null) _controller.text = widget.initialText;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    displayCupertionErrorBorder = false;
    super.initState();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus == false && widget.errorText != null) {
      displayCupertionErrorBorder = true;
    } else {
      displayCupertionErrorBorder = false;
    }
    widget.onChanged(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isIOS) {
      return Padding(
        padding: BaseStyle.listPadding,
        child: Column(
          children: [
            CupertinoTextField(
              controller: _controller,
              keyboardType: widget.textInputType,
              padding: EdgeInsets.all(12),
              placeholder: widget.hintText,
              obscureText: widget.obsecureText,
              placeholderStyle: TextFieldStyle.placeHolder,
              style: TextFieldStyle.text,
              textAlign: TextFieldStyle.textAlign,
              cursorColor: TextFieldStyle.cursorColor,
              prefix: TextFieldStyle.iconPrefix(widget.cupertinoIcon),
              decoration: (displayCupertionErrorBorder)
                  ? TextFieldStyle.cupertinoErrorDecoration
                  : TextFieldStyle.cupertinoDecoration,
              onChanged: widget.onChanged,
            ),
            (widget.errorText != null)
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text(
                          widget.errorText,
                          style: TextStyles.errorText,
                        )
                      ],
                    ))
                : Container(),
          ],
        ),
      );
    }
    return Padding(
      padding: BaseStyle.listPadding,
      child: TextField(
        controller: _controller,
        keyboardType: widget.textInputType,
        cursorColor: TextFieldStyle.cursorColor,
        style: TextFieldStyle.text,
        obscureText: widget.obsecureText,
        onChanged: widget.onChanged,
        textAlign: TextFieldStyle.textAlign,
        decoration: TextFieldStyle.materialDecoration(
            hintText: widget.hintText,
            icon: widget.materialIcon,
            errorText: widget.errorText),
      ),
    );
  }
}
