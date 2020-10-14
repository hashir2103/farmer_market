import 'dart:io';

import 'package:farmer_market/blocs/auth_bloc.dart';
import 'package:farmer_market/blocs/customer_bloc.dart';
import 'package:farmer_market/blocs/product_bloc.dart';
import 'package:farmer_market/services/firestore_service.dart';
import 'package:farmer_market/services/routes.dart';
import 'package:farmer_market/style/colorsStyle.dart';
import 'package:farmer_market/style/textstyle.dart';
import 'package:farmer_market/views/screens/home.dart';
import 'package:farmer_market/views/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final authBloc = AuthBloc();
final customerBloc = CustomerBloc();
final productBloc = ProductBloc();
final firestoreService = FirestoreService();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => authBloc),
      Provider(create: (context) => productBloc),
      Provider(create: (context) => customerBloc),
      FutureProvider(create: (context) => authBloc.isLoggedIn()),
      StreamProvider(
        create: (context) => firestoreService.fetchUnitTypes(),
      )
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    productBloc.dispose();
    customerBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isloggedIn = Provider.of<bool>(context);
    if (Platform.isIOS) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        // builder: DevicePreview.appBuilder,
        home: (isloggedIn == null)
            ? (Platform.isIOS)
                ? CupertinoPageScaffold(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
            : (isloggedIn == true) ? Home() : Login(),
        onGenerateRoute: Routes.cupertinoPageRoute,
        theme: CupertinoThemeData(
            primaryColor: AppColor.straw,
            textTheme: CupertinoTextThemeData(
                tabLabelTextStyle: TextStyles.suggestion),
            scaffoldBackgroundColor: Colors.white),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // builder: DevicePreview.appBuilder,
        home: (isloggedIn == null)
            ? (Platform.isIOS)
                ? CupertinoPageScaffold(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
            : (isloggedIn == true) ? Home() : Login(),
        onGenerateRoute: Routes.materialPageRoute,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      );
    }
  }
}
