import 'package:brew_crew/Services/brewdb.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Templates/colors.dart';
import 'package:brew_crew/Templates/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Barista extends StatefulWidget {
  const Barista({Key? key}) : super(key: key);

  @override
  State<Barista> createState() => _BaristaState();
}

class _BaristaState extends State<Barista> {
  bool _autoValidate = false;
  String name = "";
  double price = 0;
  String about = "";

  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customGreyColor,
      appBar: AppBar(
        backgroundColor: customGreyColor,
        automaticallyImplyLeading: false,
        toolbarHeight: deviceHeight * 7 / 64,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: const Text(
          "Barista Brew",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (name != "" && price != 0 && about != "") {
                  await BrewdatabaseService(brew: '')
                      .updateCoffee(name, price, about);
                }

                setState(() {
                  _autoValidate = true;
                });
              },
              icon: const Icon(
                Icons.file_upload_outlined,
                color: Colors.black,
              ))
        ],
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formkey,
              autovalidateMode: _autoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  _userInputBar("Brew", 1),
                  const SizedBox(height: 30),
                  _userInputBar("Price", 2),
                  const SizedBox(height: 30),
                  SizedBox(
                      height: deviceHeight * 1 / 2,
                      child: _userInputBar("About", 3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInputBar(String hintText, int boxNum) {
    return searchBoxContainer(
      searchField: TextFormField(
        validator: (val) {
          return (val!.isEmpty) ? "Fill Here" : null;
        },
        onChanged: (val) {
          setState(() {
            if (boxNum == 1) {
              name = val;
            } else if (boxNum == 2) {
              price = double.parse(val);
            } else {
              about = val;
            }
          });
        },
        maxLines: null,
        cursorColor: Colors.black,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: customGreyColor,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          border: customBorder(),
          enabledBorder: customBorder(),
          focusedBorder: customBorder(),
          focusedErrorBorder: customBorder(),
        ),
      ),
    );
  }
}
