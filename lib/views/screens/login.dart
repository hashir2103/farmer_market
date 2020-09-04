import 'dart:async';

import 'package:farmer_market/blocs/auth_bloc.dart';
import 'package:farmer_market/style/baseStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:farmer_market/views/widgets/AppAlerts.dart';
import 'package:farmer_market/views/widgets/AppButton.dart';
import 'package:farmer_market/views/widgets/AppSocialButton.dart';
import 'package:farmer_market/views/widgets/AppTexField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription _userSubscription;
  StreamSubscription _errorMessageSubscription;
  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    _userSubscription = authBloc.user.listen((user) {
      if (user != null) Navigator.pushReplacementNamed(context, '/home');
    });
    
    _errorMessageSubscription = authBloc.errorMessage.listen((errorMsg) {
      if (errorMsg != '') {
        AppAlert.showErrorDialog(Platform.isIOS,context, errorMsg).then((_) => authBloc.clearErrorMessage());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    _errorMessageSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context, authBloc),
      );
    } else {
      return Scaffold(
        body: pageBody(context, authBloc),
      );
    }
  }

  pageBody(context, AuthBloc authBloc) {
    final _height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Container(
          height: _height * 0.33,
          margin: EdgeInsets.only(bottom: _height * 0.05),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/1.png'), fit: BoxFit.cover)),
        ),
        StreamBuilder<String>(
            stream: authBloc.email,
            builder: (context, snapshot) {
              return AppTextField(
                  isIOS: Platform.isIOS,
                  hintText: "Email",
                  cupertinoIcon: CupertinoIcons.mail_solid,
                  materialIcon: Icons.mail,
                  textInputType: TextInputType.emailAddress,
                  errorText: snapshot.error,
                  onChanged: authBloc.changeEmail);
            }),
        StreamBuilder<String>(
            stream: authBloc.password,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: "Password",
                cupertinoIcon: IconData(0xf4c9,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                materialIcon: Icons.lock,
                obsecureText: true,
                errorText: snapshot.error,
                onChanged: authBloc.changePassword,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: "Login",
                buttonType: (snapshot.hasData)
                    ? ButtonType.LightBlue
                    : ButtonType.Disable,
                onPressed: authBloc.loginEmail ,
              );
            }),
        Padding(
          padding: BaseStyle.listPadding,
          child: Center(
            child: Text(
              "Or",
              style: TextStyles.suggestion,
            ),
          ),
        ),
        Padding(
          padding: BaseStyle.listPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSocialButton(socialType: SocialType.Facebook),
              SizedBox(
                width: 15,
              ),
              AppSocialButton(socialType: SocialType.Google),
            ],
          ),
        ),
        Padding(
          padding: BaseStyle.listPadding,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'New Here?',
                  style: TextStyles.body,
                  children: [
                    TextSpan(
                        text: ' SignUp',
                        style: TextStyles.link,
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, '/signup'))
                  ])),
        ),
      ],
    );
  }
}
