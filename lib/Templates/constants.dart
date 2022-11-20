import 'package:brew_crew/Templates/colors.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:advanced_icon/advanced_icon.dart';

double deviceHeight = 0;
double deviceWidth = 0;

OutlineInputBorder customFocusBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey[600]!));
}

OutlineInputBorder customBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: customGreyColor!),
  );
}

final customInputDecoration = InputDecoration(
  //hintText: hintText,
  fillColor: customGreyColor,
  filled: true,
  border: customFocusBorder(),
  focusedBorder: customFocusBorder(),
  enabledBorder: customBorder(),
  contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
  focusedErrorBorder: customFocusBorder(),
);

Widget searchBoxContainer({required Widget searchField}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[500]!,
          offset: const Offset(4, 4),
          blurRadius: 20,
          spreadRadius: 0.5,
        ),
        const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 20,
            spreadRadius: 0.5)
      ],
    ),
    child: searchField,
  );
}

//-----------------------------------------------
Widget explanIcon() {
  return const AdvancedIcon(
    icon: CupertinoIcons.exclamationmark_circle,
    size: 28,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.red, Colors.amber],
    ),
  );
}

Widget errorText(String text) {
  return Container(
      //height: 30,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500]!,
            offset: const Offset(4, 4),
            blurRadius: 20,
            spreadRadius: 0.5,
          ),
          const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 20,
              spreadRadius: 0.5)
        ],
      ),
      child: Row(
        children: [
          explanIcon(),
          const SizedBox(width: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.red, fontSize: 15, wordSpacing: 1),
            ),
          ),
        ],
      ));
}

List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.grey[500]!,
    offset: const Offset(4, 4),
    blurRadius: 15,
    spreadRadius: 1,
  ),
  const BoxShadow(
      color: Colors.white,
      offset: Offset(-4, -4),
      blurRadius: 15,
      spreadRadius: 1)
];
