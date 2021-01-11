import 'package:flutter/material.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_language.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsUI extends StatefulWidget {
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(image:
            new AssetImage(CommonImagePaths().backgroundImage), fit: BoxFit.cover)
        ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      //body: CommonWidgets(title: (AppLocalizations.of(context).translate('Settings')), imgPath: CommonImagePaths().iconBack,),
      body: Stack(
      children: <Widget>[
        CommonWidgets(title: (AppLocalizations.of(context).translate('Settings')),
          imgPath: CommonImagePaths().iconBack,),
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('Message'),
                  style: TextStyle(fontSize: 32),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        appLanguage.changeLanguage(Locale("en"));
                      },
                      child: Text('English'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        appLanguage.changeLanguage(Locale("ar"));
                      },
                      child: Text('العربي'),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    )
    )
    );
  }
}

class _SettingsUIState2 extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CommonWidgets(title: (AppLocalizations.of(context).translate('Settings')), imgPath: CommonImagePaths().iconBack,),

    );
  }
}

