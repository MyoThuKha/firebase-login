import 'package:brew_crew/Screens/AuthPage/login.dart';
import 'package:brew_crew/Screens/AuthPage/register.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _isLogIn = true;

  void toggleView() {
    setState(() {
      _isLogIn = !_isLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLogIn
          ? LoginPage(toggleView: toggleView)
          : Register(toggleView: toggleView),
    );
  }
}
