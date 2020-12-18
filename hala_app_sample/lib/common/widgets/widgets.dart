import 'package:flutter/material.dart';

class CommonWidgets extends StatelessWidget {

  String title;
  CommonWidgets({this.title});

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
              child: Image(image: new AssetImage('assets/images/icon_dots_vertical.png'),),
              onPressed: ()=>{},
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
}