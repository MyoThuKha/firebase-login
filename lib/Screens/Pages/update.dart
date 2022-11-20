import 'package:brew_crew/Models/brew_model.dart';
import 'package:brew_crew/Models/user_model.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Templates/colors.dart';
import 'package:brew_crew/Templates/constants.dart';
import 'package:brew_crew/Templates/load.dart';
import 'package:brew_crew/Templates/loading.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool _isElevated = true;

  bool _isLoading = false;
  String userName = "";

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map userData = ModalRoute.of(context)?.settings.arguments as Map;
    userName = userName == "" ? userData['name'] : userName;
    // print(
    //     "${userData['barista']}, ${userData['brew']}, ${userData['size']}, ${userData['cost']}");
    return GestureDetector(
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: coffeeColor,
        appBar: AppBar(
          toolbarHeight: deviceHeight * 15 / 64,
          title: const Text(
            "Change",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          backgroundColor: coffeeColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),

        //BODY PART
        body: _isLoading
            ? loadingWidget()
            : Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Form(
                    key: _formkey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: <Widget>[
                        // const SizedBox(height: 40),
                        Container(
                            margin: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              userName,
                              style: TextStyle(
                                  color: coffeeColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: customShadow,
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            decoration: customInputDecoration.copyWith(
                                hintText: "New Name"),
                            validator: (val) {
                              return (val!.isEmpty
                                  ? "Name required"
                                  // : !_userExist
                                  //     ? "User doesn't Exist"
                                  : null);
                            },
                            onChanged: (val) {
                              setState(() {
                                userName = val;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        // userInputBar(true, "New Password"),
                        const SizedBox(height: 50),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isElevated = !_isElevated;
                            });
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              await DatabaseService(uid: userData['uid'])
                                  .updateUserData(
                                userName,
                                userData['barista'],
                                userData['brew'],
                                userData['favorite'],
                                userData['total'],
                              );
                              // print(userName);
                              setState(() {
                                _isLoading = false;
                              });
                              //button reappear
                              await Future.delayed(
                                  const Duration(milliseconds: 800));
                              setState(() {
                                _isElevated = !_isElevated;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: _isElevated
                                  ? [
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
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.grey[500]!,
                                        offset: const Offset(1, 1),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                      const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-1, -1),
                                          blurRadius: 15,
                                          spreadRadius: 1)
                                    ],
                            ),
                            // child: Icon(
                            //   _isElevated
                            //       ? Icons.local_cafe_rounded
                            //       : CupertinoIcons.checkmark_alt,
                            //   color: _isElevated ? Colors.black : Colors.green,
                            //   size: 30,
                            // ),
                            child: Icon(
                              _isElevated
                                  ? Icons.save_rounded
                                  : CupertinoIcons.checkmark_alt,
                              color: _isElevated ? coffeeColor : Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Unsure?",
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Go back",
                                  style: TextStyle(
                                      fontSize: 15, color: coffeeColor),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
