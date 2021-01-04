
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hala_app_sample/common/widgets/nav_drawer.dart';
import 'package:hala_app_sample/screens/login/view/login_ui.dart';
import 'package:hala_app_sample/screens/settings/settings_view/settings_ui.dart';

class CommonWidgets extends StatelessWidget {

  final String title;
  final String imgPath;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  CommonWidgets({this.title, this.imgPath, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
      width: (MediaQuery.of(context).size.width) - 20,
      height: 60,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 60,
            child: FlatButton(
              padding: EdgeInsets.all(10),
              child: Image(image: new AssetImage(this.imgPath),),
              onPressed: ()=>{loadSettingsScreen(context, this.title)},
            )
          ),
          
          Center(
            child: Container(
              width: 300,
              child: Text(this.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    );
  }

  void loadSettingsScreen(context, String title) {
    if (title == 'Login') {
      scaffoldKey.currentState.openDrawer();
    } else {
      Navigator.pop(context);
    }
  }
}