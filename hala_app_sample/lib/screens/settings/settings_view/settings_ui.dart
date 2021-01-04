import 'package:flutter/material.dart';
import 'package:hala_app_sample/common/app_constants_or_strings/strings_or_constants.dart';
import 'package:hala_app_sample/common/widgets/widgets.dart';
import 'package:hala_app_sample/localization/app_localizations.dart';

class SettingsUI extends StatefulWidget {
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CommonWidgets(title: (AppLocalizations.of(context).translate('Settings')), imgPath: CommonImagePaths().iconBack,),
    );
  }
}