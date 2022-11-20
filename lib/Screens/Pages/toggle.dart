//This file is for routing between pages after login
import 'package:brew_crew/Screens/Pages/home.dart';
import 'package:brew_crew/Screens/Pages/settings.dart';
import 'package:flutter/material.dart';

class TogglePages extends StatefulWidget {
  const TogglePages({Key? key}) : super(key: key);

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends State<TogglePages> {
  bool _isSettings = false;
  void toggleHomeView() {
    setState(() {
      _isSettings = !_isSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !_isSettings
          ? HomePage(toggleHomeView: toggleHomeView)
          : Settings(toggleHomeView: toggleHomeView),
    );
  }
}
