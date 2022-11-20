import 'package:brew_crew/Models/brew_model.dart';
import 'package:brew_crew/Models/menu_model.dart';
import 'package:brew_crew/Templates/colors.dart';
import 'package:brew_crew/Templates/load.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<BrewModel?>(context);
    final menuData = Provider.of<List<MenuModel>?>(context);
    if (userData == null) return Expanded(child: loadingWidget());
    List favList = userData.favorite;

    // : Container(
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             "Today Special",
    //             style: TextStyle(fontSize: 30),
    //           ),
    //         ]),
    //   );
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: menuData!.length,
          itemBuilder: (context, index) {
            return !favList.contains(menuData[index].name)
                ? const SizedBox()
                : Column(
                    children: <Widget>[
                      //Coffee part
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: {
                              "name": menuData[index].name,
                              "about": menuData[index].about,
                              "price": menuData[index].price,
                            },
                          );
                        },
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          // decoration: BoxDecoration(
                          //   color: customGreyColor,
                          //   borderRadius: BorderRadius.circular(15),
                          //   boxShadow: customShadow,
                          // ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: 100,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  decoration: BoxDecoration(
                                    color: coffeeColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset("assets/coffee_cup.png"),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              menuData[index].name,
                                              style: const TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.coffee_rounded,
                                              color: coffeeColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "\$ ${menuData[index].price.toString()}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Divider(
                        indent: 40,
                        endIndent: 40,
                      ),
                      //Dummy data
                    ],
                  );
          }),
    );
  }
}
