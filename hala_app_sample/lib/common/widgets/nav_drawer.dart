import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';
import 'package:hala_app_sample/screens/settings/settings_view/settings_ui.dart';
class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(AppLocalizations.of(context).translate('HalaApp'),
              style: TextStyle(color: Colors.white, fontSize: 20),),
              decoration: BoxDecoration(
                color: ColorNames().lightYellow,
                image: DecorationImage(fit: BoxFit.fill,
                image: AssetImage(CommonImagePaths().menuHeaderBg))
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('Home')),
              onTap: () => {
                loadScreen(context, 'Home')
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('Settings')),
              onTap: () => {
                loadScreen(context, 'Settings')
              },
            ),
          ],
        ),
      );
  }

  void loadScreen(context, String title) {
    if (title == 'Settings') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsUI()));
    } else {
    }
  }
}