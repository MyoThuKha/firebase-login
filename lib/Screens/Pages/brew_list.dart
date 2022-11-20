import 'package:brew_crew/Models/brew_model.dart';
import 'package:brew_crew/Templates/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>>(context);
    // print(brews?.docs);
    // brews?.forEach((each) {
    //   print(each.name);
    //   print(each.strength);
    //   print(each.sugars);
    // });
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                    color: customGreyColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        offset: const Offset(1, 1),
                        blurRadius: 15,
                        spreadRadius: 0.5,
                      ),
                      BoxShadow(
                        color: Colors.grey[400]!,
                        offset: const Offset(-1, -1),
                        blurRadius: 15,
                        spreadRadius: 0.5,
                      )
                    ]),
              ),
            ],
          );
        });
  }
}
