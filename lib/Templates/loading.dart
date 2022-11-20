import 'package:brew_crew/Templates/colors.dart';
import 'package:brew_crew/Templates/constants.dart';
import 'package:brew_crew/Templates/load.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String text;
  const LoadingPage({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: coffeeColor,
      appBar: AppBar(
        toolbarHeight: deviceHeight * 15 / 64,
        automaticallyImplyLeading: false,
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
        backgroundColor: coffeeColor,
        elevation: 0,
      ),

      //BODY PART
      body: loadingWidget(),
    );
  }
}
