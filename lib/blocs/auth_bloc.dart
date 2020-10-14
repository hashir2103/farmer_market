import 'dart:async';

import 'package:farmer_market/models/user.dart';
import 'package:farmer_market/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

final RegExp regExpEmail = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _errorMessage = BehaviorSubject<String>();
  final _user = BehaviorSubject<MyUser>();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _service = FirestoreService();

  //getter
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get errorMessage => _errorMessage.stream;
  Stream<MyUser> get user => _user.stream;
  Stream<bool> get isValid => CombineLatestStream.combine2(email, password, (a,b) => true);
  String get userId => _user.value.userId;

  // Setter
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _email.close();
    _password.close();
    _errorMessage.close();
    _user.close();
  }

  //Tranformer of stream to validate data
  //email.trim() to pull out any extra spaces
  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (regExpEmail.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError("Please Enter A Valid Email");
    }
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError("8 Characters Minimum");
    }
  });
  //functions
  signUpemail() async {
    print('Signing Up with email and password');
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user =
          MyUser(email: authResult.user.email, userId: authResult.user.uid);
      await _service.addUser(user);
      _user.sink.add(user);
    } catch (error) {
      _errorMessage.sink.add(error.message);
    }
  }

  loginEmail() async {
    print('Login User');
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user = await _service.fetchUser(userCredential.user.uid);
      _user.sink.add(user);
    } catch (error) {
      _errorMessage.sink.add(error.message);
    }
  }

  Future<bool> isLoggedIn() async {
    User firbaseUser = _auth.currentUser;
    if (firbaseUser == null) return false;

    var user = await _service.fetchUser(firbaseUser.uid);
    if (user == null) return false;

    // print(user.email);
    _user.sink.add(user);
    return true;
  }

  logOut() async {
    await _auth.signOut();
    _user.sink.add(null);
  }

  clearErrorMessage() {
    _errorMessage.sink.add('');
  }
}
