import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/nav_drawer.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/common/widgets/nav_drawer.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();
  bool emailError = false;
  bool passwordError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
       SystemChrome.setPreferredOrientations([
         DeviceOrientation.portraitDown,
         DeviceOrientation.portraitUp
       ]) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
     key: _scaffoldKey,
     drawer: NavDrawer(),
     body: (Stack(
       children: <Widget>[
         Center(
           child: ListView(
             shrinkWrap: true,
             children: getLoginWidget(),
           ),
         ),
         new Container(
           child: CommonWidgets(title: 'Login', imgPath: CommonImagePaths().verticalImgPath,scaffoldKey: _scaffoldKey,),
         ),
       ],
     )),
    );
  }

  List<Widget> getLoginWidget() {
    List<Widget> loginWidget = new List();
    loginWidget.add(Container(
      height: 80,
    ));
    loginWidget.add(getLabelWidget('User Name'));
    loginWidget.add(getTextFieldWidget('assets/images/icon_user.png', true));
    loginWidget.add(getLabelWidget('Password'));
    loginWidget.add(getTextFieldWidget('assets/images/icon_password.png', false));
    loginWidget.add(Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          width: (MediaQuery.of(context).size.width) - 30,
          child: GestureDetector(
            child: Text('Create an account',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600,
              color: ColorNames().lightYellow),),
            onTap: ()=>{},
          ),
        )
      ],
    ));
    Column c1 = new Column(
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width) - 30,
          height: 50,
          margin: EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: RaisedButton(
            child: Text('Login',
            style: TextStyle(color: Colors.white, fontSize: 21),
            ),
            color: ColorNames().lightYellow,
            onPressed: () => {},

          ),
        ),
      ],
    );
    loginWidget.add(c1);
    return loginWidget;
  }

  Widget getEmailWidget() {
    return Center(
      child: SizedBox(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Container(
            color: Colors.white,
            child: TextFormField(
              keyboardType:TextInputType.emailAddress,
              controller: emailController,
              focusNode: emailFocus,
              onChanged: this.validate,
              style: new TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: false,
                errorText: (emailError ? 'Invalid Email' : null),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getPasswordWidget() {
    return Center(
      child: SizedBox(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Container(
            color: Colors.white,
            child: TextFormField(
              keyboardType:TextInputType.visiblePassword,
              controller: passwordController,
              focusNode: passwordFocus,
              onChanged: this.validate,
              style: new TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: false,
                errorText: (passwordError ? 'Please Enter password' : null),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLabelWidget(String title) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
          width: (MediaQuery.of(context).size.width) - 30,
          child: Text(title,
          style: new TextStyle(color: Colors.grey),),
        )
      ],
    );
  }

  Widget getTextFieldWidget(String imageName, bool isEmail) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: (MediaQuery.of(context).size.width - 30),
          height: 50,
          child: Container(
            color: Colors.white,
            child: new Row(
              children: <Widget>[
                SizedBox(
                  width: (MediaQuery.of(context).size.width) - 80,
                  height: 60,
                  child: new Container(
                    margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    color: Colors.white,
                    height: 50.0,
                    child: isEmail ? getEmailWidget() : getPasswordWidget(),
                  ),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      child: Image.asset(imageName),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void validate(String value) {
    setState(() {
      if (isEmailValid(emailController.value.text.toString())) {
        emailError = false;
      } else {
        emailError = true;
      }
      if (passwordController.value.text.toString().length <= 0) {
        passwordError = true;
      } else {
        passwordError = false;
      }
    });
  }

  bool isEmailValid(String emailValue) {
    String emailExpression = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailExpression);
    return regExp.hasMatch(emailValue);
  }
}