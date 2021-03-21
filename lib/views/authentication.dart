import 'package:flutter/material.dart';
import 'package:test1/views/sign_in.dart';
import 'package:test1/views/sign_up.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showSignIn = true;

  toggle() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignInScreen(toggle: toggle)
        : SignUpScreen(toggle: toggle);
  }
}
