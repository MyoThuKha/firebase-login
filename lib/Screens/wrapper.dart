import 'package:brew_crew/Models/user_model.dart';
import 'package:brew_crew/Screens/AuthPage/auth_page.dart';
import 'package:brew_crew/Screens/Pages/toggle.dart';
import 'package:brew_crew/Templates/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    final userData = Provider.of<UserModel?>(context);
    return userData == null ? const Authenticate() : const TogglePages();
    //return TogglePages();
  }
}
