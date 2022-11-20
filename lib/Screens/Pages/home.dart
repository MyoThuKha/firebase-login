import 'package:brew_crew/Models/brew_model.dart';
import 'package:brew_crew/Models/menu_model.dart';
import 'package:brew_crew/Models/user_model.dart';
import 'package:brew_crew/Screens/Pages/coffee.dart';
import 'package:brew_crew/Screens/Pages/orders.dart';
import 'package:brew_crew/Screens/Pages/favorite.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/Services/brewdb.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Templates/colors.dart';
import 'package:brew_crew/Templates/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleHomeView;
  const HomePage({Key? key, required this.toggleHomeView}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  @override
  void initState() {
    // _tabController = TabController(length: 3, vsync: this);
    // AuthService().signOut();
    super.initState();
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  int _activeId = 1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamProvider<List<MenuModel>?>.value(
      initialData: const [],
      value: BrewdatabaseService(brew: '').menuStream,
      catchError: (_, __) {
        return null;
      },
      child: StreamProvider<BrewModel?>.value(
        initialData: null,
        catchError: (_, __) {
          return null;
        },
        value: DatabaseService(uid: user.uid).brewStreamByUid,
        child: Scaffold(
          backgroundColor: coffeeColor,
          appBar: AppBar(
            title: const Text(
              "Brew",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            toolbarHeight: deviceHeight * 15 / 70,
            backgroundColor: coffeeColor,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    widget.toggleHomeView();
                  },
                  icon: const Icon(CupertinoIcons.line_horizontal_3_decrease))
            ],
          ),
          body: GestureDetector(
            // onPanUpdate: (details) {
            //   if (details.delta.dx < 0) {
            //     setState(() {
            //       _activeId == 3 ? null : _activeId = _activeId + 1;
            //     });
            //   }
            //   if (details.delta.dx > 0) {
            //     setState(() {
            //       _activeId == 1 ? null : _activeId = _activeId - 1;
            //     });
            //   }
            // },
            onHorizontalDragEnd: (DragEndDetails) {
              if (DragEndDetails.primaryVelocity! < 0) {
                setState(() {
                  _activeId == 3 ? null : _activeId = _activeId + 1;
                });
              }
              if (DragEndDetails.primaryVelocity! > 0) {
                setState(() {
                  _activeId == 1 ? null : _activeId = _activeId - 1;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeId = 1;
                            });
                          },
                          child: _activeId == 1
                              ? _activeTab("Menu")
                              : Text(
                                  "Menu",
                                  style: TextStyle(
                                      color: coffeeColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeId = 2;
                            });
                          },
                          child: _activeId == 2
                              ? _activeTab("Favorite")
                              : Text(
                                  "Favorite",
                                  style: TextStyle(
                                      color: coffeeColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeId = 3;
                            });
                          },
                          child: _activeId == 3
                              ? _activeTab("Orders")
                              : Text(
                                  "Orders",
                                  style: TextStyle(
                                      color: coffeeColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     widget.toggleHomeView();
                        //     // Navigator.pushNamed(context, '/settings');
                        //   },
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         "Settings",
                        //         style: TextStyle(
                        //             color: coffeeColor,
                        //             fontSize: 17,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  (_activeId == 1)
                      ? const CoffeeList()
                      : (_activeId == 2)
                          ? const Favorite()
                          : const OrderPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _customBar() {
    return Container(
      width: 30,
      height: 5,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: coffeeColor,
      ),
    );
  }

  Column _activeTab(text) {
    return Column(
      children: <Widget>[
        Text(
          "$text",
          style: TextStyle(
              color: coffeeColor, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        _customBar(),
      ],
    );
  }
}
