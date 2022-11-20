import 'package:brew_crew/Models/brew_model.dart';
import 'package:brew_crew/Models/user_model.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Templates/colors.dart';
import 'package:brew_crew/Templates/constants.dart';
import 'package:brew_crew/Templates/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  final VoidCallback toggleHomeView;
  const Settings({Key? key, required this.toggleHomeView}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isElevated = true;

  final AuthService _auth = AuthService();

  final _buttonWidth = 80.0;
  final _buttonHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final deviceHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<BrewModel>(
      stream: DatabaseService(uid: user.uid).brewStreamByUid,
      builder: (context, snapshot) {
        if (snapshot.hasError) Text("${snapshot.error}");
        if (snapshot.hasData) {
          BrewModel? userData = snapshot.data;
          return Scaffold(
            backgroundColor: customGreyColor,

            //Body area
            body: SafeArea(
              child: Center(
                child: Column(
                  children: <Widget>[
                    //will add name
                    // const Text("Lorem Ipsum"),
                    SizedBox(height: deviceHeight * 5 / 64),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: coffeeColor,
                            radius: 75,
                            child: FaIcon(
                              FontAwesomeIcons.mugSaucer,
                              color: customGreyColor,
                            ),
                          ),
                          const SizedBox(height: 50),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  userData!.name,
                                  style: TextStyle(
                                      color: coffeeColor,
                                      fontSize: 38,
                                      fontWeight: FontWeight.w600),
                                ),

                                //If user is barista
                                userData.barista
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/barista');
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: customGreyColor,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              boxShadow: customShadow,
                                            ),
                                            child: Icon(
                                              Icons.add_business_rounded,
                                              size: 35,
                                              color: coffeeColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const Divider(
                      height: 80,
                      indent: 30,
                      endIndent: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                widget.toggleHomeView();
                              },
                              child: Container(
                                width: _buttonWidth,
                                height: _buttonHeight,
                                decoration: BoxDecoration(
                                  color: customGreyColor,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: customShadow,
                                ),
                                child: const Icon(CupertinoIcons.back),
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        "uid": user.uid,
                                        "name": userData.name,
                                        "barista": userData.barista,
                                        "brew": userData.brew,
                                        "favorite": userData.favorite,
                                        "total": userData.total,
                                      });
                                },
                                child: Container(
                                  width: _buttonWidth,
                                  height: _buttonHeight,
                                  decoration: BoxDecoration(
                                    color: customGreyColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: customShadow,
                                  ),
                                  child: const Icon(CupertinoIcons.pencil),
                                ),
                              )),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isElevated = !_isElevated;
                                });
                                // await Future.delayed(
                                // const Duration(milliseconds: 250));
                                await _auth.signOut();
                              },
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  // width: 100,
                                  // height: 100,
                                  width: _buttonWidth,
                                  height: _buttonHeight,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow:
                                          _isElevated ? customShadow : null),
                                  child: const Icon(
                                    Icons.exit_to_app_rounded,
                                    size: 30,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const LoadingPage(text: "brew");
        }
      },
    );
  }
}
