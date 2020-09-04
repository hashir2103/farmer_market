
import 'package:farmer_market/MyApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  Future<FirebaseApp> init() async {
    var _initialization = await Firebase.initializeApp();
    return _initialization;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Something Went Wrong! Check Your Internet Connection'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return MyApp();
              }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
